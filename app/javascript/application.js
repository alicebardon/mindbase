// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import { makeFlashesDisappear } from "./flashes"
import { initUploadPopup } from "./upload"


document.addEventListener('turbo:load', () => {
  initUploadPopup();
  // makeFlashesDisappear();
})
