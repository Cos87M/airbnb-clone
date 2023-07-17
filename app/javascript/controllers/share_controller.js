import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="share"
export default class extends Controller {
  connect() {
    document.getElementById('share-modal-trigger').addEventListener('click', () => {
      document.getElementById('modal-container').classList.toggle('hidden');
    });
  }
  share(e) {
    e.preventDefault();
    const modalTrigger = document.getElementById('share-modal-trigger');
    if (modalTrigger) {
      modalTrigger.click();
    }
  }
}
