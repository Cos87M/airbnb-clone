import { Controller } from "@hotwired/stimulus";

// Define and export a Stimulus controller
export default class extends Controller {
  // Define the targets for the controller
  static targets = ['checkIn', 'checkOut'];

  // Method called when the controller is connected to the DOM
  connect() {
    // Initialize the check-in date picker with a minimum date
    const checkinPicker = new Datepicker(this.checkInTarget, {
      minDate: this.element.dataset.defaultCheckInDate
    });

    // Initialize the check-out date picker with a minimum date
    const checkoutPicker = new Datepicker(this.checkOutTarget, {
      minDate: this.element.dataset.defaultCheckOutDate
    });

    // Add an event listener to update the check-out date picker's minimum date when the check-in date changes
    this.checkInTarget.addEventListener('changeDate', (e) => {
      const date = new Date(e.target.value);
      date.setDate(date.getDate() + 1);
      checkoutPicker.setOptions({
        minDate: date
      });
    });

    // Add an event listener to update the check-in date picker's maximum date when the check-out date changes
    this.checkOutTarget.addEventListener('changeDate', (e) => {
      const date = new Date(e.target.value);
      date.setDate(date.getDate() - 1);
      checkinPicker.setOptions({
        maxDate: date
      });
    });
  }
}
