import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="popup"
export default class extends Controller {
  static targets = ["overlay", "popup"]

  connect() {
    // console.log("pop-up controller connected");
    // console.log(this.popup);
    // console.log(this.overlay);
    }

   openPopup() {
  //  if (popup == null) return
    this.popupTarget.classList.add('active')
    this.overlayTarget.classList.add('active')
  }

    closePopup() {
        // if (popup == null) return
      this.popupTarget.classList.remove('active')
      this.overlayTarget.classList.remove('active')
  }
}
