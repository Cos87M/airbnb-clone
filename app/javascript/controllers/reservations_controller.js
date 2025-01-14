import { Controller } from "@hotwired/stimulus";
import { isEmpty } from 'lodash-es';
import Swal from 'sweetalert2';

// Define and export a Stimulus controller
export default class extends Controller {
  // Define the targets for the controller
  static targets = ['checkIn', 'checkOut', 'updateNumberOfNights', 'nightTotal', 'serviceFee','total'];

  // Method called when the controller is connected to the DOM
  connect() {
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);
    // console.log('nightPrice: ', this.element.dataset.nightPrice)

    // Initialize the check-in date picker with a minimum date
    const checkinPicker = new Datepicker(this.checkInTarget, {
      minDate: today
    });
    // Initialize the check-out date picker with a minimum date
    const checkoutPicker = new Datepicker(this.checkOutTarget, {
      minDate: tomorrow
    });

    // Add an event listener to update the check-out date picker's minimum date when the check-in date changes
    this.checkInTarget.addEventListener('changeDate', (e) => {
      const date = new Date(e.target.value);
      date.setDate(date.getDate() + 1);
      checkoutPicker.setOptions({
        minDate: date
      });
      this.updateNumberOfNights();
      this.updateNightTotal();
      this.updateTotal();
    });

    // Add an event listener to update the check-in date picker's maximum date when the check-out date changes
    this.checkOutTarget.addEventListener('changeDate', (e) => {
      const date = new Date(e.target.value);
      date.setDate(date.getDate() - 1);
      checkinPicker.setOptions({
        maxDate: date
      });
      this.updateNumberOfNights();
      this.updateNightTotal();
      this.updateTotal();
    });
  }

  // Method to update the number of nights based on check-in and check-out dates
  updateNumberOfNights() {
    const numberOfNights = this.numberOfNights();
    this.updateNumberOfNightsTarget.textContent = numberOfNights;
    return numberOfNights; // Return the number of nights
  }

  // Method to update the total cost for the nights
  updateNightTotal() {
    const numberOfNights = this.updateNumberOfNights();
    const nightPrice = parseFloat(this.element.dataset.nightPrice);

    // Check if the parsed price is a valid number
    if (isNaN(nightPrice)) {
      throw new Error('Invalid night price value');
    }

    const nightTotal = numberOfNights * nightPrice;
    this.nightTotalTarget.textContent = nightTotal.toFixed(2);

    this.updateServiceFee(nightTotal); // Update the service fee based on the nightTotal
    this.updateTotal();
    return nightTotal; // Return the calculated value
  }

  // Method to calculate the number of nights between check-in and check-out dates
  numberOfNights() {
    if (isEmpty(this.checkInTarget.value) || isEmpty(this.checkOutTarget.value)) {
      return 0;
    }

    const checkinDate = new Date(this.checkInTarget.value);
    const checkoutDate = new Date(this.checkOutTarget.value);

    // Set hours, minutes, seconds, and milliseconds to 0 to calculate only days
    checkinDate.setHours(0, 0, 0, 0);
    checkoutDate.setHours(0, 0, 0, 0);

    // Calculate the time difference in milliseconds
    const differenceInMilliseconds = checkoutDate - checkinDate;

    // Calculate the number of nights as the difference in days (rounded up)
    const differenceInDays = Math.ceil(differenceInMilliseconds / (1000 * 60 * 60 * 24));

    return differenceInDays;
  }

  // Method to update the service fee based on the total cost for the nights
  updateServiceFee() {
    const nightTotal = parseFloat(this.nightTotalTarget.textContent);
    const serviceFeePercentage = parseFloat(this.element.dataset.serviceFee); // Parse the service fee percentage as a float
    const serviceFee = nightTotal * serviceFeePercentage;
    this.serviceFeeTarget.textContent = serviceFee.toFixed(2);
    this.updateTotal();
    return serviceFee;
  }

  // Method to update the total cost including night total, service fee, and cleaning fee
  updateTotal() {
    const nightTotal = parseFloat(this.nightTotalTarget.textContent);
    const serviceFee = parseFloat(this.serviceFeeTarget.textContent);
    const cleaningFee = parseFloat(this.element.dataset.cleaningFee);

    // console.log("nightTotal:", nightTotal);
    // console.log("serviceFee:", serviceFee);
    // console.log("cleaningFee:", cleaningFee);

    // Check if any of the values are NaN
    if (isNaN(nightTotal) || isNaN(serviceFee) || isNaN(cleaningFee)) {
      this.totalTarget.textContent = "NaN";
      return;
    }

    // Calculate the total
    const total = nightTotal + serviceFee + cleaningFee;

    // Format the total to two decimal places
    const formattedTotal = total.toFixed(2);

    // Update the total target with the formatted total
    this.totalTarget.textContent = formattedTotal;
    return formattedTotal;
  }

  // Method to build the reservation parameters
  buildReservationParams() {
    // const differenceInDays = this.numberOfNights();
    // console.log('differenceInDays in buildReservationParams:', differenceInDays);

    const params = {
      checkindate: this.checkInTarget.value,
      checkoutdate: this.checkOutTarget.value,
      subtotal: this.updateNightTotal(),
      cleaning_fee: this.element.dataset.cleaningFee,
      service_fee: this.updateServiceFee(),
      total: this.updateTotal(),
      differenceInDays: this.numberOfNights(),
    };
    const searchParams = new URLSearchParams(params);
    return searchParams.toString();
  }

  // Method to build the submit URL with reservation parameters
  buildSubmitUrl(url) {
    const params = this.buildReservationParams(); // Get the generated parameters
    return `${url}?${params}`;
  }

  // Method to handle the reservation submission
  submitReservationComponent(e) {
    if (isEmpty(this.checkInTarget.value) || isEmpty(this.checkOutTarget.value)) {
      Swal.fire({
        text: 'Please fill the check-in and checkout dates',
        icon: "error"
      });
      return;
    }
    const params = this.buildReservationParams(); // Get the generated parameters
    const newReservationUrl = this.buildSubmitUrl(e.target.dataset.submitUrl); // Use buildSubmitUrl to get the URL with parameters
    // console.log(params);

    Turbo.visit(newReservationUrl);
  }
}
