import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flashes"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add("alert-hidden");
      setTimeout(() => {
        this.element.remove();
      }, 600);
    } , 3000)
  }
}
