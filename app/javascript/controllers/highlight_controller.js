import { Controller } from "@hotwired/stimulus"
import hljs from "highlight.js/lib/common"

// Connects to data-controller="highlight"
export default class extends Controller {
  connect() {
    hljs.highlightAll();
    console.log("hello i'm connected");
  }
}
