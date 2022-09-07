import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-desktop"
export default class extends Controller {
  static targets = ["desktop", "choose"]

  connect() {
    // console.log("hey");
    // console.log(this.desktop);
    console.log(this.choose);
  }

  revealImportDesktop(event) {
    event.preventDefault();
    this.chooseTarget.classList.add("d-none")
    this.desktopTarget.classList.remove("d-none")
    // this.chooseTarget.classList.remove("d-none")
  }
}
