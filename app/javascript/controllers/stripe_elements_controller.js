import { Controller } from "@hotwired/stimulus";

// Define and export a Stimulus controller
export default class extends Controller {

  // Define the class to be added to the submit button
  submitButtonClass = "mt-4 w-full rounded-md bg-gray-900 px-6 py-3 font-medium text-white cursor-pointer"

  // Method called when the controller is connected to the DOM
  connect() {
    // let classes = "mt-4 w-full rounded-md bg-gray-900 px-6 py-3 font-medium text-white"
    // let submitButton = document.querySelector('#stripe-form input[type="submit"]');

    // console.log(submitButton);
    // submitButton.className += classes;

    // Add a margin-top class to the Stripe card element
    this.getStripeCardElements().classList.add('mt-4');
    // Hide the Stripe form label
    this.getStripeFormLabel().classList.add('hidden');
    // Add the defined class to the Stripe submit button
    this.getStripeSubmitButton().className += this.submitButtonClass;
  }

  // Method to get the Stripe submit button element
  getStripeSubmitButton() {
    return document.querySelector('#stripe-form input[type="submit"]');
  }

  // Method to get the Stripe form label element
  getStripeFormLabel() {
    return document.querySelector('label[for="card_element"]');
  }

  // Method to get the Stripe card element
  getStripeCardElements() {
    return document.getElementById('card-element');
  }
}
