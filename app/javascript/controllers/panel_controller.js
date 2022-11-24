// application/javascript/controllers/search_form_controller.js

import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search-form"
export default class extends Controller {
  static targets = [ "tab" ]

  connect() {
    this.tabTargets[0].classList.add('is-active');
  }
  onclick(e) {
    let el = this.tabTargets;
    el.forEach( e => e.classList.remove('is-active'));
    e.currentTarget.classList.add('is-active');
  }

}
