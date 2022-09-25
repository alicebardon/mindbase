import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="create-category"
export default class extends Controller {
  static targets = ["list", "form"]
  connect() {
    //onsole.log("hey connected");
    //console.log(this.listTarget, this.formTarget);
  }

  revealForm(event) {
    event.preventDefault();
    //this.listTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }
}
