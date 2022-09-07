import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-desktop"
export default class extends Controller {
  static targets = ["desktop"]

  connect() {
    // console.log("hey");
    // console.log(this.desktop);
  }

  revealImportDesktop(event) {
    event.preventDefault();
    this.desktopTarget.classList.remove("d-none")
  }
}
