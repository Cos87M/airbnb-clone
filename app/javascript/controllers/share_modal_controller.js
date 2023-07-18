import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share-modal"
export default class extends Controller {
  connect() {
    // console.log('hello from share-modal')
  }
  copyLink() {
    navigator.clipboard.writeText(this.element.dataset.shareUrl);
  }
//   shareWhatsapp() {

//   }
//   shareFacebook() {

//   }
//   shareTwitter() {

//   }
}
