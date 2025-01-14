import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-property"
export default class extends Controller {
  // Called when the controller is connected to the DOM
  connect() {
    // console.log('modal-property connected')
  }

  // Method to show the property description modal
  showDescription(e) {
    // Prevent the default action of the event
    e.preventDefault();
    // Trigger a click event on the element with ID 'property-description-trigger'
    document.getElementById('property-description-trigger').click();
  }
}
