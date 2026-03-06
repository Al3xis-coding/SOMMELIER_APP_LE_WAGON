import { Controller } from "@hotwired/stimulus"

const PHRASES = [
  "What should I pair with a cheese platter?",
  "What goes well with a grilled salmon?",
  "I'm making a romantic dinner for my girlfriend...",
  "Looking for something for a summer BBQ...",
  "I need a wine for a cozy pizza evening...",
  "Something light for a girls' night?",
]

const TYPE_SPEED = 60
const DELETE_SPEED = 30
const PAUSE_AFTER_TYPE = 1800
const PAUSE_AFTER_DELETE = 400

export default class extends Controller {
  connect() {
    this.phraseIndex = 0
    this.charIndex = 0
    this.isDeleting = false
    this.originalPlaceholder = this.element.placeholder
    this.timeout = null
    this._tick()

    this.element.addEventListener("focus", this._stop.bind(this))
    this.element.addEventListener("blur", this._resume.bind(this))
  }

  disconnect() {
    clearTimeout(this.timeout)
    this.element.removeEventListener("focus", this._stop.bind(this))
    this.element.removeEventListener("blur", this._resume.bind(this))
  }

  _tick() {
    const phrase = PHRASES[this.phraseIndex]

    if (this.isDeleting) {
      this.charIndex--
      this.element.placeholder = phrase.substring(0, this.charIndex)

      if (this.charIndex === 0) {
        this.isDeleting = false
        this.phraseIndex = (this.phraseIndex + 1) % PHRASES.length
        this.timeout = setTimeout(() => this._tick(), PAUSE_AFTER_DELETE)
      } else {
        this.timeout = setTimeout(() => this._tick(), DELETE_SPEED)
      }
    } else {
      this.charIndex++
      this.element.placeholder = phrase.substring(0, this.charIndex)

      if (this.charIndex === phrase.length) {
        this.isDeleting = true
        this.timeout = setTimeout(() => this._tick(), PAUSE_AFTER_TYPE)
      } else {
        this.timeout = setTimeout(() => this._tick(), TYPE_SPEED)
      }
    }
  }

  _stop() {
    clearTimeout(this.timeout)
    this.element.placeholder = ""
  }

  _resume() {
    if (this.element.value === "") {
      this._tick()
    }
  }
}
