module DeviceFormat
  extend ActiveSupport::Concern

  included do
    before_action :set_variant
  end

  private

  def set_variant
    request.variant = :mobile if turbo_native_app? || browser.device.mobile?
  end
end
