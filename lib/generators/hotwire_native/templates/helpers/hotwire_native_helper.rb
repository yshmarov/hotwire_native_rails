# frozen_string_literal: true

module HotwireNativeHelper
  # before
  # <title><%= content_for(:title) || "My App" %></title>
  # after
  # <title><%= page_title %></title>
  # usage
  # <% content_for :turbo_native_title, "Sign in" %>
  # <% content_for :title, "Sign in | My App" %>
  def page_title
    if turbo_native_app?
      content_for(:turbo_native_title) || content_for(:title) || Rails.application.class.module_parent.name
    else
      content_for(:title) || Rails.application.class.module_parent.name
    end
  end

  # forbid zooming on mobile devices
  def viewport_meta_tag
    content = ['width=device-width,initial-scale=1']
    content << 'maximum-scale=1, user-scalable=0' if turbo_native_app? || browser.device.mobile?
    tag.meta(name: 'viewport', content: content.join(','))
  end

  # set on <html> tag
  def platform_identifier
    'data-turbo-native' if turbo_native_app?
  end

  # link_to 'Next', next_path, data: { turbo_action: replace_if_native }
  # https://turbo.hotwired.dev/handbook/drive#application-visits
  def replace_if_native
    return 'replace' if turbo_native_app?

    'advance'
  end

  # override link_to to not open internal links in in-app browser on native app
  def link_to(name = nil, options = nil, html_options = {}, &)
    html_options[:target] = '' if turbo_native_app? && internal_url?(url_for(options))
    super
  end

  # https://github.com/joemasilotti/daily-log/blob/main/rails/app/helpers/form_helper.rb
  class BridgeFormBuilder < ActionView::Helpers::FormBuilder
    def submit(value = nil, options = {})
      options[:data] ||= {}
      options['data-bridge--form-target'] = 'submit'
      options[:class] = [options[:class], 'turbo-native:hidden'].compact
      super
    end
  end

  def bridge_form_with(*, **options, &)
    options[:html] ||= {}
    options[:html][:data] ||= {}
    options[:html][:data] = options[:html][:data].merge(bridge_form_data)

    options[:builder] = BridgeFormBuilder

    form_with(*, **options, &)
  end

  private

  def bridge_form_data
    {
      controller: 'bridge--form',
      action: 'turbo:submit-start->bridge--form#submitStart turbo:submit-end->bridge--form#submitEnd'
    }
  end

  def internal_url?(url)
    uri = URI.parse(url)
    return true if uri.path.present? && uri.host.blank?
    return true if url.include?(root_url)

    false
  end
end
