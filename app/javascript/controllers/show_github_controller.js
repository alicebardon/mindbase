import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-github"
export default class extends Controller {
static targets = ["choose2", "github"]

  connect() {
    // console.log("hey!!");
  }

  revealProjectGithub(event) {
    event.preventDefault();
        console.log("hey!!");

    this.choose2Target.classList.add("d-none")
    this.githubTarget.classList.remove("d-none")



  }
}
