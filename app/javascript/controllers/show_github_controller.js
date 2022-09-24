import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="  "
export default class extends Controller {
static targets = ["choose2", "github"]

  connect() {
   console.log("show-github controller connected");
  }

  revealProjectGithub(event) {
    event.preventDefault();
        console.log("show-github clicked");

    this.choose2Target.classList.add("d-none");
    this.githubTarget.classList.remove("d-none")

    console.log("this method has been called");
    console.log(this.element);

    // fetch("_github_upload.html.erb")
    //    .then((res) => res.text())
    //    .then((html) => {
    //      const fragment = document
    //        .createRange()
    //        .createContextualFragment(html);
    // // const textnode = document.createRange().createContextualFragment("<p> I am a p node</p>")

    //   this.element.appendChild(fragment);
    //     // OR document.getElementById("testy_element").appendChild(fragment)
    //    });

  }
}
