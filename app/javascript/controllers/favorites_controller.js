import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="favorites"
export default class extends Controller {
  connect() {
    // console.log("Favorites Controller connected!");
  }
  favorite(event) {
    event.preventDefault();

    if (this.element.dataset.userLoggedIn === 'false') {
      return document.querySelector('[data-header-target="userAuthLink"]').click();
    }

    if (this.element.dataset.favorited === 'true') {

      axios.delete(this.element.dataset.unfavoriteUrl, {

        headers: {
          "ACCEPT": "application/json"
        }
      }).then((response) => {
        this.element.dataset.favorited = 'false'
        this.element.setAttribute('fill','none');
      });

    } else {

      axios.post(this.element.dataset.favoriteUrl, {

        user_id: this.element.dataset.userId,
        property_id: this.element.dataset.propertyId
      }, {
        headers: {
        "ACCEPT": "application/json"
      }})
      .then((response) => {
        this.element.dataset.favorited = 'true'
        this.element.setAttribute('fill','#ff385c');
      });

    }
  }
}
