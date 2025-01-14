import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  // Method called when the controller is connected to the DOM
  connect() {
  }

  // Method to handle the share action
  share(e) {
    e.preventDefault();
    // console.log('share is connected');

    // Trigger a click event on the share modal trigger element
    document.getElementById('share-modal-trigger').click();
  }
}
