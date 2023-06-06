import { Controller } from "@hotwired/stimulus";


// Connects to data-controller="users-by-email-auth"
export default class extends Controller {
  static targets = ['email', 'submit','emailWrapper','invalidSvg','errorMessage']

  connect() {
    // console.log('axios: ', axios);
    this.submitTarget.addEventListener('click', (e) => {
      e.preventDefault();

      if(this.emailTarget.value.length === 0) {
        console.log('inside if email field is empty')
        // email field is empty, so don't do anything
        this.emailWrapperTarget.classList.add('invalid-input-text-field');
        this.emailWrapperTarget.classList.remove('text-gray-700');
        this.invalidSvgTarget.classList.remove('hidden');
        this.errorMessageTarget.classList.remove('hidden');
      } else {
        // email field is filled, so do something
        axios.get('/users_by_email', {
          params: {
            email: this.emailTarget.value
          },
          headers: {
           'ACCEPT': 'application/json'
          }
        }).then((response) => {
          Turbo.visit('/users/sign_in');
        }).catch((response) => {
          Turbo.visit('/users/sign_up');
        })
      }
    });

  }
}
