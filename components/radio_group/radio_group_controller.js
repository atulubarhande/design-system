import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ['input']
    static classes = []

    connect() {}

    handleChange(e) {
        const parentContainer = e.target.closest('.radio-group-field')
        parentContainer.querySelector('.field').value = e.target.value
    }
}
