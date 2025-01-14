// Stimulus controller
import { Controller } from "@hotwired/stimulus";

// Define and export a Stimulus controller
export default class extends Controller {
  // Define the targets for the controller
  static targets = ["link", "content"];
  activeLink = null;

  // Method called when the controller is connected to the DOM
  connect() {
    // Add click event listeners to each link target
    this.linkTargets.forEach(link => {
      link.addEventListener("click", this.handleLinkClick.bind(this));
    });
    this.markActiveLink();
  }

  // Method to handle link click events
  handleLinkClick(event) {
    event.preventDefault();
    const clickedLink = event.currentTarget;
    const target = clickedLink.getAttribute("data-target");

    // Remove the active class from the previously active link
    if (this.activeLink) {
      this.activeLink.classList.remove("active");
    }

    // Remove the active class from all link targets and hide all content targets
    this.linkTargets.forEach(link => link.classList.remove("active"));
    this.contentTargets.forEach(content => content.classList.add("hidden"));

    // Add the active class to the clicked link and show the corresponding content
    clickedLink.classList.add("active");
    this.element.querySelector(`#${target}`).classList.remove("hidden");

    // Update the active link reference
    this.activeLink = clickedLink;
  }

  // Method to mark the initially active link
  markActiveLink() {
    const activeLink = this.element.querySelector(".active");
    if (activeLink) {
      this.activeLink = activeLink;
    }
  }
}
