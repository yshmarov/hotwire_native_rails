# Hotwire Native Rails generator

Power pack to make your Rails app [Hotwire Native](https://native.hotwired.dev)

## Installation

Install the gem:

```sh
bundle add hotwire_native_rails
```

Run the generator:

```sh
rails g hotwire_native_rails
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
- `bridge_form_with` - easily apply Bridge Form component

#### Path Configuration
- `path_configuration_controller` for `ios` and `android`
