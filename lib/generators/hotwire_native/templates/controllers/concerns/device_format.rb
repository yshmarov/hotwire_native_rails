module DeviceFormat
  extend ActiveSupport::Concern

  included do
    before_action :set_variant
  end

  private

  def set_variant
    return request.variant = :native if turbo_native_app?
  end
end
