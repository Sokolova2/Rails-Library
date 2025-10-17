import { Controller } from "@hotwired/stimulus"

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
