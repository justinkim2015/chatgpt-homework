import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu" ]

  toggle() {
    const menu = this.menuTarget
    menu.classList.toggle('active')
    menu.classList.toggle('inactive')
  }
}
