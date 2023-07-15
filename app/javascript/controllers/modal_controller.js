import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"

export default class extends Controller {
  static targets = ["closeButton"];

  connect() {
    const triggerId = this.element.dataset.modalTriggerId;

    document.addEventListener('click', (event) => {
      if (event.target.id === triggerId) {
        this.showModal(triggerId);
      } else {
        this.closeModal(event, triggerId);
      }
    });

    this.closeButtonTarget.addEventListener('click', () => {
      this.closeModal(null, triggerId);
    });
  }

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
