import { BridgeComponent } from "@hotwired/hotwire-native-bridge"
// Source:
// https://github.com/hotwired/hotwire-native-demo/blob/main/public/javascript/controllers/bridge/overflow_menu_controller.js
// Docs:
// https://blog.corsego.com/hotwire-native-bridge-menu-component

export default class extends BridgeComponent {
  static component = "overflow-menu"

  connect() {
    super.connect()
    this.notifyBridgeOfConnect()
  }

  notifyBridgeOfConnect() {
    const label = this.bridgeElement.title

    this.send("connect", { label }, () => {
      this.bridgeElement.click()
    })
  }
}
