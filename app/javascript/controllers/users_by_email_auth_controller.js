import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="users-by-email-auth"
export default class extends Controller {
  // Define the targets for the controller
  static targets = ['email', 'submit','emailWrapper','invalidSvg','errorMessage']

  // Method called when the controller is connected to the DOM
  connect() {
    // Add a click event listener to the submit button
    this.submitTarget.addEventListener('click', (e) => {
      e.preventDefault();

      // Check if the email field is empty
      if(this.emailTarget.value.length === 0) {
        console.log('inside if email field is empty')
        // Email field is empty, show error styles and messages
        this.emailWrapperTarget.classList.add('invalid-input-text-field');
        this.emailWrapperTarget.classList.remove('text-gray-700');
        this.invalidSvgTarget.classList.remove('hidden');
        this.errorMessageTarget.classList.remove('hidden');
      } else {
        // Email field is filled, check if the user exists
        axios.get('/users_by_email', {
          params: {
            email: this.emailTarget.value
          },
          headers: {
           'ACCEPT': 'application/json'
          }
        }).then((response) => {
          // If the user exists, redirect to the sign-in page
          Turbo.visit('/users/sign_in');
        }).catch((response) => {
          // If the user does not exist, redirect to the sign-up page
          Turbo.visit('/users/sign_up');
        })
      }
    });
  }
}
