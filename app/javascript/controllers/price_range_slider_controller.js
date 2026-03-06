import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["minInput", "maxInput", "minVal", "maxVal", "range"]
  static values = {
    boundMin: { type: Number, default: 0 },
    boundMax: { type: Number, default: 150 }
  }

  connect() {
    this.update()
  }

  minChanged() {
    const min = parseInt(this.minInputTarget.value)
    const max = parseInt(this.maxInputTarget.value)
    if (min >= max) this.minInputTarget.value = max - parseInt(this.minInputTarget.step)
    this.update()
  }

  maxChanged() {
    const min = parseInt(this.minInputTarget.value)
    const max = parseInt(this.maxInputTarget.value)
    if (max <= min) this.maxInputTarget.value = min + parseInt(this.maxInputTarget.step)
    this.update()
  }

  update() {
    const min = parseInt(this.minInputTarget.value)
    const max = parseInt(this.maxInputTarget.value)
    const rangeMin = this.boundMinValue
    const rangeMax = this.boundMaxValue

    const minPct = ((min - rangeMin) / (rangeMax - rangeMin)) * 100
    const maxPct = ((max - rangeMin) / (rangeMax - rangeMin)) * 100

    this.rangeTarget.style.left = `${minPct}%`
    this.rangeTarget.style.width = `${maxPct - minPct}%`

    const isActive = min > rangeMin || max < rangeMax
    this.minValTarget.textContent = `€${min} – `
    this.maxValTarget.textContent = `€${max}`
    this.element.classList.toggle("price-slider--active", isActive)
  }

  submit() {
    const min = parseInt(this.minInputTarget.value)
    const max = parseInt(this.maxInputTarget.value)

    // At full range = no filter; strip names so they don't appear in URL
    if (min <= this.boundMinValue && max >= this.boundMaxValue) {
      this.minInputTarget.removeAttribute("name")
      this.maxInputTarget.removeAttribute("name")
    }

    this.element.closest("form").submit()
  }
}
