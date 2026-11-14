# Hotwire Native Rails generator

Power pack to make your Rails app [Hotwire Native](https://native.hotwired.dev)

## Installation

Requires `turbo-rails` 2.0.11 or newer (for the `hotwire_native_app?` helper).

Install the gem:

```sh
bundle add hotwire_native_rails
```

Run the generator:

```sh
rails g hotwire_native
```

## Usage

#### Helpers
- `viewport_meta_tag` - forbid zooming on mobile/native
- use `data: { turbo_action: replace_if_native }` to submit authentication forms & forms in modals
- `:native` request variant for Hotwire Native requests: `index.html+native.erb`
- override `link_to` so internal links open in the app, not the in-app browser (drops `target="_blank"` for your own host; works with and without a block)
- conditionally override page `<title>` for native apps

#### CSS
- `hotwire-native:` css variant (works with CSS and Tailwind)

#### Bridge Components
- install Hotwire Native Bridge (works with Importmaps and Node)
- add default bridge components (`Form`, `Menu`, `Button`)
- add `Nav` (UIMenu) component
- add `Review Prompt` component
- `bridge_form_with` - easily apply Bridge `Form` component

#### Path Configuration
- `path_configuration_controller` for `ios` and `android`
- Tabs controller - re-route native tabs

## Development

Run the local version of the gem:

```ruby
gem 'hotwire_native_rails', path: '/Users/myusername/Documents/GitHub.nosync/hotwire_native_rails'
```

Test the generator in brand-new Rails apps (Tailwind 4, Tailwind 3 and plain CSS). Each run generates an app under `tmp/`, runs `rails g hotwire_native`, checks what it changed and runs the generated tests:

```sh
bin/smoke tailwind4   # or tailwind3, css
bundle exec rake      # all three
```

Make a release to rubygems:

```sh
# 1. update version in version.rb and CHANGELOG.md
# 2. build the gem
gem build hotwire_native_rails.gemspec
# 3. push it to rubygems
gem push hotwire_native_rails-X.Y.Z.gem
```

- [Github source](https://github.com/yshmarov/hotwire_native_rails)
- [Rubygems source](https://rubygems.org/gems/hotwire_native_rails)
