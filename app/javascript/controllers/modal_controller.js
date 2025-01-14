import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"

export default class extends Controller {
  static targets = ["closeButton"];

  connect() {
    // Get the trigger ID from the data attribute
    const triggerId = this.element.dataset.modalTriggerId;

    // Add event listener to document to handle modal open/close
    document.addEventListener('click', (event) => {
      if (event.target.id === triggerId) {
        this.showModal(triggerId);
      } else {
        this.closeModal(event, triggerId);
      }
    });

    // Add event listener to close button to handle modal close
    this.closeButtonTarget.addEventListener('click', () => {
      this.closeModal(null, triggerId);
    });
  }

  // Method to close the modal
  closeModal(event, triggerId) {
    const wrapperElement = document.getElementById(`modal-${triggerId}-wrapper`);
    const backdropElement = document.getElementById(`modal-${triggerId}-backdrop`);
    const panelElement = document.getElementById(`modal-${triggerId}-panel`);

    if (wrapperElement && backdropElement && panelElement) {
      if (!event || event.target.id === triggerId) {
        leave(wrapperElement);
        leave(backdropElement);
        leave(panelElement);
      }
    }
  }

  // Method to show the modal
  showModal(triggerId) {
    const wrapperElement = document.getElementById(`modal-${triggerId}-wrapper`);
    const backdropElement = document.getElementById(`modal-${triggerId}-backdrop`);
    const panelElement = document.getElementById(`modal-${triggerId}-panel`);

    if (wrapperElement && backdropElement && panelElement) {
      enter(wrapperElement);
      enter(backdropElement);
      enter(panelElement);
    }
  }
}
