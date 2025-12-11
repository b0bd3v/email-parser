import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bar"]

  connect() {
    if (this.hasBarTarget) {
      this.animateProgressBar()
    }
    
    this.timer = setTimeout(() => {
      this.remove()
    }, 5000)
  }

  disconnect() {
    if (this.timer) {
      clearTimeout(this.timer)
    }
  }

  animateProgressBar() {
    // Force a reflow to ensure the transition happens if we were to set width 0 immediately (though via CSS it's better)
    // We'll trust the CSS transition.
    // Set duration to 5s linear
    this.barTarget.style.transition = "width 5s linear"
    
    // Slight delay to ensure the browser has painted the initial state
    requestAnimationFrame(() => {
        this.barTarget.style.width = "0%"
    })
  }

  remove() {
    this.element.style.transition = "opacity 0.5s ease-out, transform 0.5s ease-out"
    this.element.style.opacity = "0"
    this.element.style.transform = "translateY(-20px)"
    
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}
