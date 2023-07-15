import { Controller } from "@hotwired/stimulus"
import { toggle } from "el-transition"

export default class extends Controller {
  static targets = ['openUserMenu', 'userAuthLink'];

  connect() {
    // console.log("work")
    this.openUserMenuTarget.addEventListener('click', this.toggleDropdownMenu);

    this.userAuthLinkTargets.forEach((link)=> {
      link.addEventListener('click',(e) => {
        e.preventDefault();
        document.getElementById('user-auth-modal-trigger').click();
        this.closeDropdownMenu();
      });
    });
    document.addEventListener('click', this.closeDropdownMenuOutside);
  }
  disconnect() {
    document.removeEventListener('click', this.closeDropdownMenuOutside);
  }

  toggleDropdownMenu() {
    toggle(document.getElementById('menu-dropdown-items'));
  }
  // method that closes the menu if it's open
  closeDropdownMenu = () => {
    const menu = document.getElementById('menu-dropdown-items');
    if (menu.classList.contains('hidden')) return;
    toggle(menu);
  }
  // method that listens for clicks outside the menu and closes it accordingly
  closeDropdownMenuOutside = (event) => {
    const menu = document.getElementById('menu-dropdown-items');
    if (!menu.contains(event.target) && !this.openUserMenuTarget.contains(event.target)) {
      this.closeDropdownMenu();
    }
  }
}
