import { Controller } from "@hotwired/stimulus"
import hljs from "highlight.js/lib/common"

// Connects to data-controller="note-edit"
export default class extends Controller {
  static targets = ["comment", "code", "comment", "commentEditor"]

  connect() {
    console.log("Note edit controller now connected");
  }

  update_comment(event) {
    const note_id = this.commentTarget.dataset.noteId;
    const request_body = JSON.stringify({ note: { comment: this.commentTarget.innerText } });
    this.#update_request(note_id, request_body);
  }

  update_code(event) {
    const note_id = this.codeTarget.dataset.noteId;
    const request_body = JSON.stringify({ note: { code: this.codeTarget.innerText.trim() } });
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
