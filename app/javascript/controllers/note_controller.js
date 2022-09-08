import { Controller } from "@hotwired/stimulus"
import { end } from "@popperjs/core";
import hljs from "highlight.js/lib/common"

// Connects to data-controller="note"
export default class extends Controller {
  static targets = ["form", "newNote", "bigButton",
                    "comment", "code", "language"]

  connect() {
    console.log("note controller connected")
    // console.log(this.element)
  }

  new_note() {
    console.log("new note triggered");
    this.bigButtonTarget.hidden = true;
    this.newNoteTarget.hidden = false;
  }

  send(event) {
    event.preventDefault();
    const comment = this.commentTarget.value;
    const code = this.codeTarget.value;
    const language = this.languageTarget.value;

    // only send the update to the back end if all the mandatory fields 
    // have been filled in
    if (code == "" || comment == "" || language == "") {
      return;
    }

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => {
        return response.json();
      })
      .then((data) => {
        console.log(data)
        this.formTarget.outerHTML = data.form;
        this.element.insertAdjacentHTML('beforebegin', data.inserted_item);
        hljs.highlightAll();
        this.newNoteTarget.hidden = true;
        this.bigButtonTarget.hidden = false;
        console.log("SENT!");
      });
  }
}
