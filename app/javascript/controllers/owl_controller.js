import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="owl"
export default class extends Controller {
  connect() {
    this.owl_carousel()
  }

  owl_carousel(){
    $('.carousel').owlCarousel({
      loop: true,
      autoWidth: true,
    })
  }
}
