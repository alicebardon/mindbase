import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="note-edit"
export default class extends Controller {
  connect() {
    console.log("Note edit controller now connected");
  }

  edit_comment() {
    console.log("Editing comment");
    console.log(this.commentTarget.textContent);
    console.log(this.showEditFormTarget.hidden);
    console.log(this.showEditFormTarget)
    this.showEditFormTarget.classList.remove("d-none");
    console.log(this.showEditFormTarget.hidden);
  }

  edit_code() {
    console.log("Editing code");
    console.log(this.codeTarget)
  }

}
