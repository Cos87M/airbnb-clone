// Stimulus controller
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["link", "content"];
  activeLink = null;

  connect() {
    this.linkTargets.forEach(link => {
      link.addEventListener("click", this.handleLinkClick.bind(this));
    });
    this.markActiveLink();
  }

  handleLinkClick(event) {
    event.preventDefault();
    const clickedLink = event.currentTarget;
    const target = clickedLink.getAttribute("data-target");

    if (this.activeLink) {
      this.activeLink.classList.remove("active");
    }

    this.linkTargets.forEach(link => link.classList.remove("active"));
    this.contentTargets.forEach(content => content.classList.add("hidden"));

    clickedLink.classList.add("active");
    this.element.querySelector(`#${target}`).classList.remove("hidden");

    this.activeLink = clickedLink;
  }

  markActiveLink() {
    const activeLink = this.element.querySelector(".active");
    if (activeLink) {
      this.activeLink = activeLink;
    }
  }
}
