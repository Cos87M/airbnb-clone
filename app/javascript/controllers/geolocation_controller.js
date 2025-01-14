import { Controller } from "@hotwired/stimulus"
import { getDistance, convertDistance } from 'geolib';
import { isEmpty } from 'lodash-es';

// Connects to data-controller="geolocation"
export default class extends Controller {
  static targets = ['property'];

  connect() {
    // console.log(this.element.dataset.latitude);
    // console.log(this.element.dataset.longitude);

    // Initialize description elements to show full text on hover
    const descrip = document.getElementsByClassName("descrip");
    Array.from(descrip).forEach(descrip => {
      const content = descrip.innerHTML;
      descrip.addEventListener("mouseover", () => {
        descrip.style.whiteSpace = "normal";
        descrip.style.display = "block";
        descrip.style.textOverflow = "clip";
      });
      descrip.addEventListener("mouseout", () => {
        descrip.style.whiteSpace = "nowrap";
        descrip.style.display = "-webkit-box";
        descrip.style.textOverflow = "ellipsis";
      });
    });

    // Check if latitude and longitude are not set, then get user's current position
    if (isEmpty(this.element.dataset.latitude) &&  isEmpty(this.element.dataset.longitude)) {
      window.navigator.geolocation.getCurrentPosition((position) => {
        this.setUserCoordonates(position.coords);

      });
    } else {
      // If coordinates are already set, calculate and display distances
      this.setDistanceText();
    }
    // console.log(this.propertyTargets);

  }

  // Set user's coordinates in the dataset
  setUserCoordonates(coordonates) {
    this.element.dataset.latitude = coordonates.latitude;
    this.element.dataset.longitude = coordonates.longitude;
  }

  // Get user's coordinates from the dataset
  getUserCoordonates() {
    return {
      latitude: this.element.dataset.latitude,
      longitude: this.element.dataset.longitude,
    }
  }

  // Calculate and set the distance text for each property target
  setDistanceText() {
    this.propertyTargets.forEach((propertyTarget) => {
      let distanceFrom = getDistance(
        this.getUserCoordonates(),
        { latitude: propertyTarget.dataset.latitude, longitude: propertyTarget.dataset.longitude },
      );
      // Calculate the distance in kilometers and round it
      var distanceInKm = convertDistance(distanceFrom, 'km');
      var roundedDistance = Math.round(distanceInKm);
      // Set the distance text in the property target
      propertyTarget.querySelector('[data-distance-away]').innerHTML = `${roundedDistance} kilometers away`;
    });
  }
}
