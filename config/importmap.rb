# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true

pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"


pin "el-transition", to: "https://ga.jspm.io/npm:el-transition@0.0.7/index.js"
pin "geolib", to: "https://ga.jspm.io/npm:geolib@3.3.4/es/index.js"

# A modern JavaScript utility library delivering modularity, performance & extras.
pin "lodash-es", to: "https://ga.jspm.io/npm:lodash-es@4.17.21/lodash.js"
