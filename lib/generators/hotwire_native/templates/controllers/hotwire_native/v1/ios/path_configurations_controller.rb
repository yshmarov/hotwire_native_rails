class HotwireNative::V1::Ios::PathConfigurationsController < ActionController::Base
  def show
    render json:
      {
        "settings": {
          "enable_feature_x": true
        },
        "rules": [
          {
            "patterns": [
              "/new$",
              "/edit$",
              "/signin$",
              "/strada-form$"
            ],
            "properties": {
              "context": "modal",
              "pull_to_refresh_enabled": false
            }
          },
          {
            "patterns": [
              "^/users/edit$"
            ],
            "properties": {
              "context": "default"
            }
          },
          {
            "patterns": [
              "/numbers$"
            ],
            "properties": {
              "view_controller": "numbers"
            }
          },
          {
            "patterns": [
              "/numbers/[0-9]+$"
            ],
            "properties": {
              "view_controller": "numbers_detail",
              "context": "modal"
            }
          },
          {
            "patterns": [
              "^/$"
            ],
            "properties": {
              "presentation": "replace_root"
            }
          },
        ]
      }
  end
end
