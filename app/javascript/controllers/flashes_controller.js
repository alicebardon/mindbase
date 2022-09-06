import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flashes"
export default class extends Controller {
  connect() {
    console.log("I am the FLASHES controller!");
    setTimeout(() => {
      console.log("deleting...")
      this.element.classList.add("alert-hidden");
    } , 3000)
  }

  fade_flash() {
    console.log("I will make the flash fade away");
  }
}
