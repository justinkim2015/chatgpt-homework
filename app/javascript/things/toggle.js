let hamburger = document.querySelector('.ham-button')
let hamMenu = document.getElementById('ham-menu')

function toggle() {
  hamMenu.classList.toggle('nav-links-mobile')
  hamMenu.classList.toggle('nav-links-mobile-active')
}

hamburger.addEventListener('click', toggle)