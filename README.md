# Hotwire Native Rails generator

Power pack to make your Rails app [Hotwire Native](https://native.hotwired.dev)

## Installation

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
- `:mobile` request variant. `index.html+mobile.erb`
- override link_to to not open internal links in in-app browser on native app

#### CSS
- `turbo-native:` css variant (works with CSS and Tailwind)

#### Bridge Components
- install Hotwire Native Bridge (works with Importmaps and Node)
- add default bridge components (`Form`, `Menu`, `Button`)
- add `Nav` (UIMenu) bridge component
- `bridge_form_with` - easily apply Bridge `Form` component

#### Path Configuration
- `path_configuration_controller` for `ios` and `android`

## Development

Make a release to rubygems:

```sh
# 1. update version in version.rb
# 2. zip the gem
gem build hotwire_native_rails.gemspec
# 3. push the zip to rubygems
gem push hotwire_native_rails-0.2.0.gem
```

- [Github source](https://github.com/yshmarov/hotwire_native_rails)
- [Rubygems source](https://rubygems.org/gems/hotwire_native_rails)
