const initUploadPopup = () => {

const openPopupButtons = document.querySelectorAll('[data-popup-target]')
const overlay = document.getElementById('overlay')

openPopupButtons.forEach(button => {
  button.addEventListener('click', (event) => {
    event.preventDefault()
    console.log("er");
    const popup = document.querySelector(button.dataset.popupTarget)
    openPopup(popup)
  })
})

overlay.addEventListener('click', () => {
  const popups = document.querySelectorAll('.popup.active')
  popups.forEach(popup => {
    closePopup(popup)
  })
})
}

function openPopup(popup) {
  if (popup == null) return
  popup.classList.add('active')
  overlay.classList.add('active')
}

function closePopup(popup) {
  console.log(popup);
  if (popup == null) return
  popup.classList.remove('active')
  overlay.classList.remove('active')
}

export {
  initUploadPopup
}
