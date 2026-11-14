require "bundler/gem_tasks"

SMOKE_FLAVORS = %w[tailwind4 tailwind3 css].freeze

desc "Run the generator in fresh Rails apps (#{SMOKE_FLAVORS.join(", ")}) and run their tests"
task :test do
  # bin/smoke runs `rails new` and the new app's own bundle, so leave this gem's bundle.
  Bundler.with_unbundled_env do
    SMOKE_FLAVORS.each { |flavor| sh "bin/smoke #{flavor}" }
  end
end

task default: :test
