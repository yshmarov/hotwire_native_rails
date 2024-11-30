class HotwireNativeGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def copy_files
    # helpers
    copy_file "helpers/hotwire_native_helper.rb", "app/helpers/hotwire_native_helper.rb"
    copy_file "test_unit/hotwire_native_helper_test.rb", "test/helpers/hotwire_native_helper_test.rb"

    # routes
    copy_file "routes/hotwire_native.rb", "config/routes/hotwire_native.rb"
    copy_file "controllers/hotwire_native/v1/android/path_configuration_controller.rb", "app/controllers/hotwire_native/v1/android/path_configuration_controller.rb"
    copy_file "controllers/hotwire_native/v1/ios/path_configuration_controller.rb", "app/controllers/hotwire_native/v1/ios/path_configuration_controller.rb"

    # :native request variant
    copy_file "controllers/concerns/device_format.rb", "app/controllers/concerns/device_format.rb"
 end

  def add_detect_device_to_application_controller
    inject_into_class "app/controllers/application_controller.rb", ApplicationController, "  include DetectDevice\n"
  end

  def add_routes
    route "draw(:hotwire_native)"
  end
end
