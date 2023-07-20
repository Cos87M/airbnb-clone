import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-property"
export default class extends Controller {
  connect() {
    // console.log('modal-property connected')
  }
  showDescription(e) {
    e.preventDefault();
    document.getElementById('property-description-trigger').click();
  }
}
