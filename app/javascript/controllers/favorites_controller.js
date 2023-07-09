import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="favorites"
export default class extends Controller {
  HEADERS = {'ACCEPT': 'application/json' };
  connect() {
    // console.log("Favorites Controller connected!");
  }
  favorite(event) {
    event.preventDefault();
    if (this.element.dataset.userLoggedIn === 'false') {
      return document.querySelector('[data-header-target="userAuthLink"]').click();
    }

    if (this.element.dataset.favorited === 'true') {

      axios.delete(this.getUnFavoritePath(this.element.dataset.favoriteId), {
        headers: this.HEADERS

      }).then((response) => {
        this.element.dataset.favorited = 'false'
        this.element.dataset.favoriteId  = '';
        this.element.setAttribute('fill','none');
      });

    } else {

      axios.post(this.getFavoritePath(), {

        user_id: this.element.dataset.userId,
        property_id: this.element.dataset.propertyId
      }, {
        headers: this.HEADERS
      })
      .then((response) => {
        this.element.dataset.favorited = 'true'
        this.element.dataset.favoriteId = response.data.id;
        this.element.setAttribute('fill','#ff385c');
      });

    }
  }
  getFavoritePath() {
    return '/favorites';
  }
  getUnFavoritePath(favoriteId) {
    return `/favorites/${favoriteId}`;
  }
}
