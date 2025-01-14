import { Controller } from "@hotwired/stimulus"
import { toggle } from "el-transition"

export default class extends Controller {
  static targets = ['openUserMenu', 'userAuthLink','search'];

  connect() {

    // Search-form from navbar
    this.searchTarget.addEventListener('click', (e) => {
      e.preventDefault();
      document.getElementById(e.target.dataset.targetId).click();
    })

    // Add event listener to open user menu
    this.openUserMenuTarget.addEventListener('click', this.toggleDropdownMenu);

    // Add event listeners to user authentication links
    this.userAuthLinkTargets.forEach((link)=> {
      link.addEventListener('click',(e) => {
        e.preventDefault();
        document.getElementById('user-auth-modal-trigger').click();
        this.closeDropdownMenu();
      });
    });

    // Add event listener to close dropdown menu when clicking outside
    document.addEventListener('click', this.closeDropdownMenuOutside);

  }
  disconnect() {
    // Remove event listener when the controller is disconnected
    document.removeEventListener('click', this.closeDropdownMenuOutside);
  }

  // Toggle the dropdown menu visibility
  toggleDropdownMenu() {
    toggle(document.getElementById('menu-dropdown-items'));
  }
  // Method that closes the menu if it's open
  closeDropdownMenu = () => {
    const menu = document.getElementById('menu-dropdown-items');
    if (menu.classList.contains('hidden')) return;
    toggle(menu);
  }
  // Method that listens for clicks outside the menu and closes it accordingly
  closeDropdownMenuOutside = (event) => {
    const menu = document.getElementById('menu-dropdown-items');
    if (!menu.contains(event.target) && !this.openUserMenuTarget.contains(event.target)) {
      this.closeDropdownMenu();
    }
  }
}
