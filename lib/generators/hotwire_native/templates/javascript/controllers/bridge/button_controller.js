import { BridgeComponent } from "@hotwired/hotwire-native-bridge"
// Source:
// https://native.hotwired.dev/ios/bridge-components
// Docs:
// https://blog.corsego.com/hotwire-native-bridge-button
export default class extends BridgeComponent {
  static component = "button"

  connect() {
    super.connect()

    const element = this.bridgeElement
    const title = element.bridgeAttribute("title")
    const image = element.bridgeAttribute("ios-image")
    const side = element.bridgeAttribute("side") || "right"
    this.send("connect", {title, image, side}, () => {
      this.element.click()
    })
  }
}
