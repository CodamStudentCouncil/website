import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "yes", "no", "abstain" ]

  connect() {
    let children = this.element.children;
    for (let i = 0; i < children.length; i++) {
      let input = children[i].children[0];

      if (input.checked) {
        if (input.value == "yes") {
          this.toggleYes();
        } else if (input.value == "no") {
          this.toggleNo();
        } else if (input.value == "abstain") {
          this.toggleAbstain();
        }
      }
    }
  }

  toggleYes() {
    this.changeYes(true);
    this.changeNo(false);
    this.changeAbstain(false);
  }

  toggleNo() {
    this.changeYes(false);
    this.changeNo(true);
    this.changeAbstain(false);
  }

  toggleAbstain() {
    this.changeYes(false);
    this.changeNo(false);
    this.changeAbstain(true);
  }

  changeYes(active) {
    if (active) {
      this.yesTarget.classList.add("bg-green-500", "text-white");
      this.yesTarget.classList.remove("text-green-500", "hover:bg-green-100");
    } else {
      this.yesTarget.classList.add("text-green-500", "hover:bg-green-100");
      this.yesTarget.classList.remove("bg-green-500", "text-white");
    }
  }

  changeNo(active) {
    if (active) {
      this.noTarget.classList.add("bg-red-500", "text-white");
      this.noTarget.classList.remove("text-red-500", "hover:bg-red-100");
    } else {
      this.noTarget.classList.add("text-red-500", "hover:bg-red-100");
      this.noTarget.classList.remove("bg-red-500", "text-white");
    }
  }

  changeAbstain(active) {
    if (active) {
      this.abstainTarget.classList.add("bg-gray-500", "text-white");
      this.abstainTarget.classList.remove("text-gray-500", "hover:bg-gray-200");
    } else {
      this.abstainTarget.classList.add("text-gray-500", "hover:bg-gray-200");
      this.abstainTarget.classList.remove("bg-gray-500", "text-white");
    }
  }
}
