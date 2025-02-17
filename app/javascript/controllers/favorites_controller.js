import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Headers for JSON requests
  HEADERS = { 'Accept': 'application/json', 'Content-Type': 'application/json' };

  connect() {
    // Method called when the controller is connected to the DOM
    // console.log("Favorites Controller connected!");
  }

  favorite(event) {
    event.preventDefault();

    // Check if the user is logged in
    if (this.element.dataset.userLoggedIn === 'false') {
      // Redirect to sign-in page if user is not logged in
      // document.querySelector('[data-header-target="userAuthLink"]').click();
      Turbo.visit('/users/sign_in')
    }

    // Toggle favorite/unfavorite based on current state
    if (this.element.dataset.favorited === 'true') {
      this.unfavoriteProperty();
    } else {
      this.favoriteProperty();
    }
  }

  // Get the path for creating a favorite
  getFavoritePath() {
    return '/favorites';
  }

  // Get the path for deleting a favorite
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

    // Send a POST request to create a favorite
    fetch(this.getFavoritePath(), {
      method: 'POST',
      headers: this.HEADERS,
      body: JSON.stringify(data)
    })
      .then(response => response.json())
      .then(responseData => {
        // Update the element's dataset with the new favorite ID
        // console.log('Response Data:', responseData); // Log the entire response data
        const favoriteId = responseData.data && responseData.data.id;
        // console.log('Favorite ID:', favoriteId);
        this.element.dataset.favorited = 'true';
        this.element.dataset.favoriteId = favoriteId;
        this.element.setAttribute('fill', this.element.dataset.favoritedColor);
      })
      // .catch(error => console.error('Error creating favorite:', error));
      .catch(error => console.error('Error creating favorite:', error, error.response));
  }

  unfavoriteProperty() {
    const favoriteId = this.element.dataset.favoriteId;
    // console.log('unfavorite favoriteId:', favoriteId); // Log the favoriteId value

    if (favoriteId) {
      const url = this.getUnFavoritePath(favoriteId);
      // console.log('DELETE URL:', url); // Log the DELETE URL
      // Send a DELETE request to remove the favorite
      fetch(url, {
        method: 'DELETE',
        headers: this.HEADERS
      })
        .then(response => {
          // console.log('response:', response);
          if (response.ok) {
            // Update the element's dataset to reflect the unfavorited state
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
