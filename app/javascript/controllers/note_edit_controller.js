import { Controller } from "@hotwired/stimulus"
import hljs from "highlight.js/lib/common"

// Connects to data-controller="note-edit"
export default class extends Controller {
  static targets = ["comment", "code", "comment", "codeEditor", "commentEditor"]

  connect() {
    console.log("Note edit controller now connected");
  }

  edit_comment() {
    console.log("Editing comment");
    this.commentEditorTarget.classList.remove("d-none");
    this.commentTarget.classList.add("d-none");
  }

  edit_code() {
    console.log("Editing code");
    this.codeEditorTarget.classList.remove("d-none");
    this.codeTarget.classList.add("d-none");
  }

  update_comment(event) {
    const note_id = this.commentEditorTarget.dataset.noteId;
    const request_body = JSON.stringify({ note: { comment: this.commentEditorTarget.value } });
    this.#update_request(note_id, request_body);
  }

  update_code(event) {
    const note_id = this.codeEditorTarget.dataset.noteId;
    const request_body = JSON.stringify({ note: { code: this.codeEditorTarget.value } });
    this.#update_request(note_id, request_body);
  }

  #update_request(note_id, request_body) {
    fetch(`${window.location.pathname}/notes/${note_id}`, {
      method: "PATCH",
      headers: { "Accept": "application/json", "Content-Type": "application/json"},
      body: request_body
      })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        this.element.innerHTML = data.note_html;
        hljs.highlightAll();
      });
  }
}
