import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.modal = new bootstrap.Modal(this.element)
    this.modal.show()
  }

  disconnect () {
    this.modal.hide()
    console.log("modal-controller disconnected")
  }
}
