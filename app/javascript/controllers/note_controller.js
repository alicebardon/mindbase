import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="note"
export default class extends Controller {
  static targets = ["form", "showme", "hideme"]

  connect() {
    console.log("note controller connected")
  }

  new_note() {
    console.log("new note triggered");
    this.hidemeTarget.hidden = true;
    this.showmeTarget.hidden = false;
  }

  send(event) {
    event.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })

    console.log("SENT!")
  }
}
