import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo"
export default class extends Controller {
  connect() {
    this.element.setAttribute("data-action", "click->turbo#click")
    console.log("Turbo Controller Connected")
  }
}
