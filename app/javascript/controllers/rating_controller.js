import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="rating"
export default class extends Controller {
  static targets = ["input"]
  connect() {
    this.inputTarget.forEach(input =>{
      input.addEventListener('change', () => this.rating())
    })
  }

  submitRating(){
    this.element.requestSubmit()
  }
}
