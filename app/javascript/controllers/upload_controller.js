import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "placeholder", "filename"]
  static values = { filesSelected: String }

  connect() {
    this.reset()
  }

  handleFileSelect() {
    const files = this.inputTarget.files
    if (files.length > 0) {
      if (files.length === 1) {
        this.filenameTarget.textContent = files[0].name
      } else {
        this.filenameTarget.textContent = this.filesSelectedValue.replace("%{count}", files.length)
      }
      
      this.previewTarget.classList.remove("hidden")
      this.placeholderTarget.classList.add("hidden")
      
      // Add success border state
      this.element.classList.add("border-indigo-500", "bg-gray-800/60")
      this.element.classList.remove("border-gray-700")
    } else {
      this.reset()
    }
  }

  reset() {
    this.previewTarget.classList.add("hidden")
    this.placeholderTarget.classList.remove("hidden")
    this.element.classList.remove("border-indigo-500", "bg-gray-800/60")
    this.element.classList.add("border-gray-700")
  }
}
