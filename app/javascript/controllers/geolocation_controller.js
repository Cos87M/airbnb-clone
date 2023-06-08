import { Controller } from "@hotwired/stimulus"
import { getDistance, convertDistance } from 'geolib';

// Connects to data-controller="geolocation"
export default class extends Controller {
  static targets = ['property'];
  connect() {
    // console.log(this.propertyTargets);

    window.navigator.geolocation.getCurrentPosition((position) => {

      this.element.dataset.latitude = position.coords.latitude;
      this.element.dataset.longitude = position.coords.longitude;



      // console.log(convertDistance(distance, "km"));
      // console.log('distance: ', distance);

      this.propertyTargets.forEach((propertyTarget) => {
        // console.log(propertyTarget.dataset.latitude);
        // console.log(propertyTarget.dataset.longitude);

        // console.log(propertyTarget.querySelector('[data-distance-away]'));

        let distanceFrom = getDistance(
          { latitude: position.coords.latitude, longitude:position.coords.longitude},
          { latitude: propertyTarget.dataset.latitude, longitude: propertyTarget.dataset.longitude},
        );
          // Calculate the distance
        var distanceInKm = convertDistance(distanceFrom, 'km');
        // Round the distance to the nearest whole number
        var roundedDistance = Math.round(distanceInKm);
        // propertyTarget.querySelector('[data-distance-away]').innerHTML = `${convertDistance((distanceFrom), 'km')} kilometers away`;
        propertyTarget.querySelector('[data-distance-away]').innerHTML = `${roundedDistance} kilometers away`;
      });
    });

     // With this script, when you hover over the "description" elements, the hidden text will be displayed by expanding the element and clipping the overflow.
    // When you move the mouse out, the element will be restored to its original state with ellipsis.
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

  }
}