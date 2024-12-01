# frozen_string_literal: true

require_relative "lib/hotwire_native_rails/version"

Gem::Specification.new do |spec|
  spec.name = "hotwire_native_rails"
  spec.version = HotwireNativeRails::VERSION
  spec.authors = ["Yaro Shm"]
  spec.email = ["yshmarov@gmail.com"]

  spec.summary = "Generate Hotwire Native Rails helpers and bridge components"
  spec.homepage = "https://github.com/yshmarov/hotwire_native_rails"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/yshmarov/hotwire_native_rails/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) || f.end_with?('.gem') }
  end
end
