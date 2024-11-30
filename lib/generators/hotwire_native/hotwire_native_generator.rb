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
  end

  def add_routes
    route "draw(:hotwire_native)"
  end
end
