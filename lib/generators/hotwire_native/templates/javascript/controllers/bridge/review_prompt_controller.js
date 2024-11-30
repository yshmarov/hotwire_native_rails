import { BridgeComponent } from "@hotwired/hotwire-native-bridge"
// Docs:
// https://blog.corsego.com/hotwire-native-leave-a-review-bridge-component
export default class extends BridgeComponent {
  static component = "review-prompt"

  connect() {
    super.connect()
    this.send("connect")
  }
}
