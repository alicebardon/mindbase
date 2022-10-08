import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["searchBar"]

  connect() {
    console.log("Search Connected")
  }

  test_click() {
    console.log("you clicked the search box");
    // this.searchBarTarget.hidden = true;
    // this.searchBarTarget.hidden = false;
  }
}
