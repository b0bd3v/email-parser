import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    // Initial state set in HTML
  }

  open(e) {
    if (e) e.preventDefault()
    this.modalTarget.classList.remove("hidden")
    this.modalTarget.classList.add("flex")
  }

  close() {
    this.modalTarget.classList.remove("flex")
    this.modalTarget.classList.add("hidden")
  }
}
