import { Controller } from "@hotwired/stimulus";
// import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // Set the Mapbox access token
    mapboxgl.accessToken = this.apiKeyValue;

    // console.log("map controller")
    // console.log("Connecting map controller");
    // console.log("API Key:", this.apiKeyValue);
    // console.log("Markers Value:", this.markersValue);

    // Check if markers are defined and not empty
    // if (this.markersValue === undefined || this.markersValue === null) {
    //   console.error("Markers value is undefined or null");
    //   return;
    // }
    // if (!this.markersValue || this.markersValue.length === 0) {
    //   console.error("Markers value is empty or undefined");
    //   return;
    // }

    // Initialize the map
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11"
    });

    // Add markers to the map
    this.#addMarkersToMap();
    // Adjust the map view to fit the markers
    this.#fitMapToMarkers();

    // Listen to the scroll event and adjust map position
    window.addEventListener('scroll', () => {
      const scrollY = window.scrollY;
      const mapContainer = document.querySelector('.map-container');
      mapContainer.style.transform = `translateY(${scrollY}px)`;
    });
  }

  // Private method to add markers to the map
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
    });
  }

  // Private method to adjust the map view to fit the markers
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
