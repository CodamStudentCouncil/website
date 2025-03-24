import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "withAbstain", "withoutAbstain", "label" ];
  static currentState = "hidden";

  connect() {
    this.currentState = "hidden";
  }

  toggle() {
    if (this.currentState === "hidden") {
      console.log("Enabling abstains", this.element);
      this.currentState = "shown";
      this.labelTarget.textContent = "Hide Abstain Votes";
      this.showAbstains();
    } else {
      console.log("Disabling abstains", this.element);
      this.currentState = "hidden";
      this.labelTarget.textContent = "Show Abstain Votes";
      this.hideAbstains();
    }
  }

  showAbstains() {
    for (let i = 0; i < this.withAbstainTargets.length; i++) {
      const element = this.withAbstainTargets[i];
      element.classList.remove("hidden");
      element.classList.add("flex");
    }
    for (let i = 0; i < this.withoutAbstainTargets.length; i++) {
      const element = this.withoutAbstainTargets[i];
      element.classList.remove("flex");
      element.classList.add("hidden");
    }
  }

  hideAbstains() {
    for (let i = 0; i < this.withAbstainTargets.length; i++) {
      const element = this.withAbstainTargets[i];
      element.classList.remove("flex");
      element.classList.add("hidden");
    }
    for (let i = 0; i < this.withoutAbstainTargets.length; i++) {
      const element = this.withoutAbstainTargets[i];
      element.classList.remove("hidden");
      element.classList.add("flex");
    }
  }

}
