let hamburger = document.querySelector('.ham-button')
let hamMenu = document.getElementById('ham-menu')

function toggle() {
  hamMenu.classList.toggle('active')
  hamMenu.classList.toggle('inactive')
}

hamburger.addEventListener('click', toggle)