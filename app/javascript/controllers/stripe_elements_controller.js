import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  submitButtonClass = "mt-4 w-full rounded-md bg-gray-900 px-6 py-3 font-medium text-white cursor-pointer"

  connect() {
    // let classes = "mt-4 w-full rounded-md bg-gray-900 px-6 py-3 font-medium text-white"
    // let submitButton = document.querySelector('#stripe-form input[type="submit"]');

    // console.log(submitButton);
    // submitButton.className += classes;

    this.getStripeCardElements().classList.add('mt-4');
    this.getStripeFormLabel().classList.add('hidden');
    this.getStripeSubmitButton().className += this.submitButtonClass;

  }
  getStripeSubmitButton() {
    return document.querySelector('#stripe-form input[type="submit"]');
  }

  getStripeFormLabel() {
    return document.querySelector('label[for="card_element"]');
  }

  getStripeCardElements() {
    return document.getElementById('card-element');
  }
}
