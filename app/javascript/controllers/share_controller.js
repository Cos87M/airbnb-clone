import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  connect() {
  }
  share(e) {
    e.preventDefault();
    // console.log('share is connected');

    document.getElementById('share-modal-trigger').click();
  }
}
