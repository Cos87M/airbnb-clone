import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorites"
export default class extends Controller {
  connect() {
  }
  favorite(event) {
    event.preventDefault();

    if (this.element.dataset.favorited === 'true') {
      this.element.dataset.favorited = 'false'
      this.element.setAttribute('fill','none');
    } else {
      this.element.dataset.favorited = 'true'
      this.element.setAttribute('fill','#ff385c');
    }
  }
}
