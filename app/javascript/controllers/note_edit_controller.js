import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="note-edit"
export default class extends Controller {
  static targets = ["comment", "code", "comment", "codeEditor", "commentEditor"]

  connect() {
    console.log("Note edit controller now connected");
  }

  edit_comment() {
    console.log("Editing comment");
    console.log(this.commentTarget)
    console.log(this.commentEditorTarget);
    this.commentEditorTarget.classList.remove("d-none");
    this.commentTarget.classList.add("d-none");
  }

  edit_code() {
    console.log("Editing code");
    this.codeEditorTarget.classList.remove("d-none");
    this.codeTarget.classList.add("d-none");
  }

  update_comment(event) {
    const note_id = this.commentEditorTarget.id.split("-").pop();
    console.log(this.commentEditorTarget.value);
    fetch(`${window.location.pathname}/notes/${note_id}`, {
          method: "PATCH",
          headers: { "Accept": "application/json"},
          body: this.commentEditorTarget.content
          });

    this.commentEditorTarget.classList.add("d-none");
    this.commentTarget.classList.remove("d-none");
    console.log("Comment updated!");
  }

  update_code(event) {
    console.log("Code updated!");
  }
}
