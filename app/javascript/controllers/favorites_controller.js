import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  HEADERS = { 'Accept': 'application/json', 'Content-Type': 'application/json' };

  connect() {
    // console.log("Favorites Controller connected!");
  }

  favorite(event) {
    event.preventDefault();

    if (this.element.dataset.userLoggedIn === 'false') {
      document.querySelector('[data-header-target="userAuthLink"]').click();
    }

    if (this.element.dataset.favorited === 'true') {
      this.unfavoriteProperty();
    } else {
      this.favoriteProperty();
    }
  }

  getFavoritePath() {
    return '/favorites';
  }

  getUnFavoritePath(favoriteId) {
    return `/favorites/${favoriteId}`;
  }

  favoriteProperty() {
    const userId = this.element.dataset.userId;
    const propertyId = this.element.dataset.propertyId;

    const data = {
      favorite: {
        user_id: userId,
        property_id: propertyId
      }
    };

    fetch(this.getFavoritePath(), {
      method: 'POST',
      headers: this.HEADERS,
      body: JSON.stringify(data)
    })
      .then(response => response.json())
      .then(responseData => {
        // console.log('Response Data:', responseData); // Log the entire response data
        const favoriteId = responseData.data && responseData.data.id;
        // console.log('Favorite ID:', favoriteId);
        this.element.dataset.favorited = 'true';
        this.element.dataset.favoriteId = favoriteId;
        this.element.setAttribute('fill', this.element.dataset.favoritedColor);
      })
      .catch(error => console.error('Error creating favorite:', error));
  }

  unfavoriteProperty() {
    const favoriteId = this.element.dataset.favoriteId;
    // console.log('unfavorite favoriteId:', favoriteId); // Log the favoriteId value

    if (favoriteId) {
      const url = this.getUnFavoritePath(favoriteId);
      // console.log('DELETE URL:', url); // Log the DELETE URL
      fetch(url, {
        method: 'DELETE',
        headers: this.HEADERS
      })
        .then(response => {
          // console.log('response:', response);
          if (response.ok) {
            this.element.dataset.favorited = 'false';
            this.element.removeAttribute('data-favorite-id');
            this.element.setAttribute('fill', this.element.dataset.unfavoritedColor);
          } else {
            console.error('Error deleting favorite:', response.statusText);
          }
        })
        .catch(error => console.error('Error deleting favorite:', error));
    }
  }

}
