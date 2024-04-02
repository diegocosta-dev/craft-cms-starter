import Alpine from 'alpinejs'
import focus from '@alpinejs/focus'

window.Alpine = Alpine

// document.addEventListener('alpine:init', () => {
//   window.Alpine.data('siteHeader', siteHeader),
// })

window.Alpine.plugin(focus)
window.Alpine.start()