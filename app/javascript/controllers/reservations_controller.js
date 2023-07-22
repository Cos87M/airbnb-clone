import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reservation"
export default class extends Controller {

  static targets= ['checkIn', 'checkOut'];

  connect() {
    // console.log('controller reservations connected')
    // console.log('Datepicker: ', Datepicker);
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);

    // Set the minimum date to today for the check-in datepicker
    new Datepicker(this.checkInTarget, {
      minDate: today
    });
    // Set the minimum date to tomorrow for the check-out datepicker
    new Datepicker(this.checkOutTarget, {
      minDate: tomorrow
    });
  }
}
