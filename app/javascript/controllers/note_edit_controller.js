import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="note-edit"
export default class extends Controller {
  static targets = ["comment", "code", "comment", "codeEditor", "commentEditor"]

  connect() {
    console.log("Note edit controller now connected");
  }

  edit_comment() {
    console.log("Editing comment");
    console.log(this.commentTarget.textContent);
    this.commentTarget.classList.add("d-none");
    this.showEditFormTarget.classList.remove("d-none");
  }

  edit_code() {
    console.log("Editing code");
    this.codeTarget.classList.add("d-none");
    console.log(this.codeTarget)
  }

  update_code(event) {
    console.log("Code updated!");
  }
}
