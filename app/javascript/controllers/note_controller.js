import { Controller } from "@hotwired/stimulus"
import hljs from "highlight.js/lib/common"

// Connects to data-controller="note"
export default class extends Controller {
  static targets = ["form", "showme", "hideme"]

  connect() {
    console.log("note controller connected")
    // console.log(this.element)
  }

  new_note() {
    console.log("new note triggered");
    this.hidemeTarget.hidden = true;
    this.showmeTarget.hidden = false;
  }

  send(event) {
    event.preventDefault();

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        this.formTarget.outerHTML = data.form;
        this.element.insertAdjacentHTML('beforebegin', data.inserted_item);
        hljs.highlightAll();
        this.showmeTarget.hidden = false;
        this.hidemeTarget.hidden = true;
        console.log("SENT!");
      });
  }
}
