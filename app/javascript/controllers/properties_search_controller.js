import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['checkIn', 'checkOut', ];

  connect() {
    const checkinPicker = new Datepicker(this.checkInTarget, {
      minDate: this.element.dataset.defaultCheckInDate
    });

    const checkoutPicker = new Datepicker(this.checkOutTarget, {
      minDate: this.element.dataset.defaultCheckOutDate
    });

    this.checkInTarget.addEventListener('changeDate', (e) => {
      const date = new Date(e.target.value);
      date.setDate(date.getDate() + 1);
      checkoutPicker.setOptions({
        minDate: date
      });
    });

    this.checkOutTarget.addEventListener('changeDate', (e) => {
      const date = new Date(e.target.value);
      date.setDate(date.getDate() - 1);
      checkinPicker.setOptions({
        maxDate: date
      });
    });


  }
}
