import { Controller } from "@hotwired/stimulus";
import { isEmpty } from 'lodash-es';
import Swal from 'sweetalert2';

export default class extends Controller {
  static targets = ['checkIn', 'checkOut', 'updateNumberOfNights', 'nightTotal', 'serviceFee','total'];

  connect() {
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);
    // console.log('nightPrice: ', this.element.dataset.nightPrice)

    const checkinPicker = new Datepicker(this.checkInTarget, {
      minDate: today
    });
    const checkoutPicker = new Datepicker(this.checkOutTarget, {
      minDate: tomorrow
    });

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

  updateNumberOfNights() {
    const numberOfNights = this.numberOfNights();
    this.updateNumberOfNightsTarget.textContent = numberOfNights;
    return numberOfNights; // Return the number of nights
  }

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
  }

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

  updateServiceFee() {
    const nightTotal = parseFloat(this.nightTotalTarget.textContent);
    const serviceFeePercentage = parseFloat(this.element.dataset.serviceFee); // Parse the service fee percentage as a float
    const serviceFee = nightTotal * serviceFeePercentage;
    this.serviceFeeTarget.textContent = serviceFee.toFixed(2);
    this.updateTotal();
  }
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

  }
  buildReservationParams() {
    const params = {
      checkindate: this.checkInTarget.value,
      checkoutdate: this.checkOutTarget.value,
      subtotal: this.updateNightTotal(),
      cleaning_fee: this.element.dataset.cleaningFee,
      service_fee: this.updateServiceFee(),
      total: this.updateTotal(),
    };
    const searchParams = new URLSearchParams(params);
    return searchParams.toString();
  }

  buildSubmitUrl(url) {
    return `${url}?${this.buildReservationParams()}`;
  }
  submitReservationComponent(e) {
    if (isEmpty(this.checkInTarget.value) || isEmpty(this.checkOutTarget.value)) {
      Swal.fire({
        text: 'Please fill the check-in and checkout dates',
        icon: "error"
    });
      return;
    }
    const newReservationUrl = e.target.dataset.submitUrl;
    Turbo.visit(newReservationUrl);
  }
}
