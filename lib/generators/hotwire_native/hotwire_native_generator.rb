class HotwireNativeGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def copy_files
    copy_file "helpers/hotwire_native_helper.rb", "app/helpers/hotwire_native_helper.rb"
    copy_file "test_unit/hotwire_native_helper_test.rb", "test/helpers/hotwire_native_helper_test.rb"

    copy_file "routes/hotwire_native.rb", "config/routes/hotwire_native.rb"
  end

  def add_routes
    route "draw(:hotwire_native)"
  end
end
