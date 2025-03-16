import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
        this.dismiss();
    }, 5000);
  }

  dismiss() {
    this.element.classList.add("fade-out");
    setTimeout(() => {
        this.element.remove();
    }, 1000);
  }
}
