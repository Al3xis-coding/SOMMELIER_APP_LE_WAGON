// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

//Needed for homepage animation
document.addEventListener("turbo:load", () => {
  const items = document.querySelectorAll("[data-reveal]");

  items.forEach((el, i) => {
    const delay = Number(el.dataset.revealDelay || 45); // 30–60ms stagger
    el.style.transitionDelay = `${i * delay}ms`;

    requestAnimationFrame(() => {
      el.classList.add("is-visible");
    });
  });
});
