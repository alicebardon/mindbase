import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Connects to data-controller="turbo"
// $ this is how you make a partial rendering for turbo stream pop ups... make sure to set the data controller on the right element, and also set up the turbo frame in view and then do a turbo frame replace
export default class extends Controller {
  connect() {
    this.element.setAttribute("data-action", "click->turbo#click")
    console.log("Turbo Controller Connected")
  }

  click(e){
    e.preventDefault()
    this.url = this.element.getAttribute("href")
    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(t => t.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}
// $$
