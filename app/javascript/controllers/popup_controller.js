import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="popup"
export default class extends Controller {
  static targets = ["overlay", "popup"]

  connect() {
    console.log("dft");
    console.log(this.popup);
    console.log(this.overlay);

    // this.popup.addEventListener('click', (event) => {
    //   event.preventDefault()
    //   openPopup(this.popup)
    // })

    // this.overlay.addEventListener('click', () => {
    //     closePopup(this.popup)
    // })

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
