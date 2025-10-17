# frozen_string_literal: true

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@popperjs/core', to: 'popper.js', preload: true
pin 'bootstrap', to: 'bootstrap.bundle.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
