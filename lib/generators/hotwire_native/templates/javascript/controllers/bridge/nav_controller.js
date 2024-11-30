import { BridgeComponent, BridgeElement } from "@hotwired/hotwire-native-bridge"

// Docs:
// https://blog.corsego.com/hotwire-native-ui-menu-dropdown
export default class extends BridgeComponent {
  static component = "nav"
  static targets = ["item"]

  connect() {
    super.connect()

    const items = this.itemTargets.map((item, index) => {
      const itemElement = new BridgeElement(item)

      return {
        title: itemElement.title,
        image: itemElement.bridgeAttribute("image") ?? "none",
        destructive: item.dataset.turboMethod === "delete",
        state: itemElement.bridgeAttribute("state") ?? "off",
        index
      }
    })

    const element = this.bridgeElement
    const title = element.bridgeAttribute("title") ?? ""
    const side = element.bridgeAttribute("side") || "left"
    const image = element.bridgeAttribute("image") || "none"

    this.send("connect", { items, title, image, side }, (message) => {
      const selectedIndex = message.data.selectedIndex
      const selectedItem = new BridgeElement(this.itemTargets[selectedIndex]);

      selectedItem.click()
    })
  }
}
