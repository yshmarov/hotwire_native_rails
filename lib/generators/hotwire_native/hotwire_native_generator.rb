class HotwireNativeGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def add_gems
    gem "browser"
    run "bundle install"
  end

  def copy_files
    # helpers
    copy_file "helpers/hotwire_native_helper.rb", "app/helpers/hotwire_native_helper.rb"
    copy_file "test_unit/hotwire_native_helper_test.rb", "test/helpers/hotwire_native_helper_test.rb"
    copy_file "test_unit/hotwire_native_controller_test.rb", "test/controllers/hotwire_native_controller_test.rb"

    # routes
    copy_file "routes/hotwire_native.rb", "config/routes/hotwire_native.rb"
    copy_file "controllers/hotwire_native/v1/android/path_configurations_controller.rb", "app/controllers/hotwire_native/v1/android/path_configurations_controller.rb"
    copy_file "controllers/hotwire_native/v1/ios/path_configurations_controller.rb", "app/controllers/hotwire_native/v1/ios/path_configurations_controller.rb"
    copy_file "controllers/hotwire_native/tabs_controller.rb", "app/controllers/hotwire_native/tabs_controller.rb"
    copy_file "test_unit/path_configurations_controller_test.rb", "test/controllers/path_configurations_controller_test.rb"

    # :native request variant
    copy_file "controllers/concerns/device_format.rb", "app/controllers/concerns/device_format.rb"
 end

  def add_detect_device_to_application_controller
    inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\n" do
      "  include DeviceFormat\n"
    end
  end

  def add_routes
    route "draw(:hotwire_native)"
  end

  # https://native.hotwired.dev/reference/bridge-installation
  def install_javascript
    copy_file "javascript/controllers/bridge/button_controller.js", "app/javascript/controllers/bridge/button_controller.js"
    copy_file "javascript/controllers/bridge/menu_controller.js", "app/javascript/controllers/bridge/menu_controller.js"
    copy_file "javascript/controllers/bridge/form_controller.js", "app/javascript/controllers/bridge/form_controller.js"
    copy_file "javascript/controllers/bridge/overflow_menu_controller.js", "app/javascript/controllers/bridge/overflow_menu_controller.js"
    copy_file "javascript/controllers/bridge/nav_controller.js", "app/javascript/controllers/bridge/nav_controller.js"
    copy_file "javascript/controllers/bridge/review_prompt_controller.js", "app/javascript/controllers/bridge/review_prompt_controller.js"

    run "bin/importmap pin @hotwired/stimulus @hotwired/hotwire-native-bridge" if importmaps?
    run "yarn add @hotwired/stimulus @hotwired/hotwire-native-bridge" if node?
  end

  def add_viewport_meta_tag
    gsub_file "app/views/layouts/application.html.erb", "<meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">", "<%= viewport_meta_tag %>"
  end

  def add_css_variants
    return add_tailwind_css_variants if tailwind?

    add_hotwire_native_css
  end

  def add_platform_identifier
    gsub_file "app/views/layouts/application.html.erb", "<html>", "<html <%= platform_identifier %>>"
  end

  def set_page_title
    gsub_file "app/views/layouts/application.html.erb", /<title>.*<\/title>/, "<title><%= page_title %></title>"
  end

  private

  def importmaps?
    Rails.root.join("config/importmap.rb").exist?
  end

  def node?
    Rails.root.join("package.json").exist?
  end

  def tailwind?
    Rails.root.join("config/tailwind.config.js").exist?
  end

  # class="hotwire-native:hidden"
  # class="non-hotwire-native:hidden"
  def add_tailwind_css_variants
    prepend_to_file "config/tailwind.config.js", "const plugin = require('tailwindcss/plugin')\n"

    inject_into_file "config/tailwind.config.js", after: "plugins: [" do
      <<-JS

  plugin(function({ addVariant }) {
    addVariant("hotwire-native", "html[data-hotwire-native] &"),
    addVariant("non-hotwire-native", "html:not([data-hotwire-native]) &")
  }),
      JS
    end
  end

  # class="hotwire-native:hidden"
  def add_hotwire_native_css
    gsub_file "app/views/layouts/application.html.erb", "<body>", "<body class=\"<%= \"hotwire-native\" if turbo_native_app? %>\">"

    append_to_file "app/assets/stylesheets/application.css" do
      <<-CSS

body.hotwire-native .d-hotwire-native-none {
  display: none !important;
}
      CSS
    end
  end
end
