import { BridgeComponent, BridgeElement } from "@hotwired/hotwire-native-bridge"
// aka UIMenu

// Docs:
// https://blog.corsego.com/hotwire-native-ui-menu-dropdown

// Example:
// <%= tag.div data: { controller: 'bridge--nav', bridge_side: 'left', bridge_image: 'person.circle' } do %>
//   <%= link_to "Users", users_path, data: { bridge__nav_target: 'item', bridge_image: 'person.circle' } %>
//   <%= link_to "Tasks", tasks_path, data: { bridge__nav_target: 'item', bridge_image: 'checklist' } %>
// <% end %>
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
