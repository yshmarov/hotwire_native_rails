## [Unreleased]

## [0.5.0] - 2026-11-14

- Generated code uses `hotwire_native_app?` instead of `turbo_native_app?` (#2). Requires `turbo-rails` >= 2.0.11.
- Fix: Tailwind 3 apps crashed the generator (`add_tailwind_3_css_variants` was undefined).
- Fix: Tailwind 4 apps did not get the `hotwire-native:` variants, because `@import "tailwindcss";` (double quotes) was not matched.
- Fix: the `link_to` override now also drops `target` for internal links written with a block, and no longer modifies the options hash passed in (#9).
- `internal_url?` compares against the request host instead of `root_url`, and treats `mailto:`/`tel:` links as external.
- README: the request variant is `:native` (`index.html+native.erb`), not `:mobile`.
- CI runs the generator in fresh Tailwind 4, Tailwind 3 and plain-CSS Rails apps (`bin/smoke`).

## [0.1.0] - 2024-11-30

- Initial release
