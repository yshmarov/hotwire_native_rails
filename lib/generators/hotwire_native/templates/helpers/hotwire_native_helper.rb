# frozen_string_literal: true

module HotwireNativeHelper
  def viewport_meta_tag
    content = ['width=device-width,initial-scale=1']
    content << 'maximum-scale=1, user-scalable=0' if turbo_native_app? || browser.device.mobile?
    tag.meta(name: 'viewport', content: content.join(','))
  end

  def platform_identifier
    'data-turbo-native' if turbo_native_app?
  end

  def replace_if_native
    return 'replace' if turbo_native_app?

    'advance'
  end

  def link_to(name = nil, options = nil, html_options = {}, &block)
    html_options[:target] = '' if turbo_native_app? && internal_url?(url_for(options))
    super(name, options, html_options, &block)
  end

  class BridgeFormBuilder < ActionView::Helpers::FormBuilder
    def submit(value = nil, options = {})
      options[:data] ||= {}
      options["data-bridge--form-target"] = "submit"
      options[:class] = [options[:class], "turbo-native:hidden"].compact
      super(value, options)
    end
  end

  def bridge_form_with(*, **options, &block)
    options[:html] ||= {}
    options[:html][:data] ||= {}
    options[:html][:data] = options[:html][:data].merge(bridge_form_data)

    options[:builder] = BridgeFormBuilder

    form_with(*, **options, &block)
  end

  private

  def bridge_form_data
    {
      controller: "bridge--form",
      action: "turbo:submit-start->bridge--form#submitStart turbo:submit-end->bridge--form#submitEnd"
    }
  end

  def internal_url?(url)
    uri = URI.parse(url)
    return true if uri.path.present? && uri.host.blank?
    return true if url.include?(root_url)

    false
  end
end
