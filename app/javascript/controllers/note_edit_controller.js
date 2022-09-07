import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="note-edit"
export default class extends Controller {
  static targets = ["comment", "code", "showEditForm", "editNoteForm"]

  connect() {
    console.log("Note edit controller now connected");
  }

  edit_comment() {
    console.log("Editing comment");
    console.log(this.commentTarget.textContent);
    this.commentTarget.classList.add("d-none");
    this.codeTarget.classList.add("d-none");
    this.showEditFormTarget.classList.remove("d-none");
    console.log(this.showEditFormTarget.hidden);
  }

  edit_code() {
    console.log("Editing code");
    console.log(this.codeTarget)
  }

}
