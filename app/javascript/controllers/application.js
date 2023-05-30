import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// import '@hotwired/turbo-rails'
// import 'alpine-turbo-drive-adapter'
// import Alpine from 'alpinejs'

// window.Alpine = Alpine
// Alpine.start()
