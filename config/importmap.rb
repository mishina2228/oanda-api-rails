# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.4/dist/esm/index.js"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@fortawesome/fontawesome-svg-core", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@1.3.0/index.es.js"
pin "@fortawesome/free-regular-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-regular-svg-icons@6.0.0/index.es.js"
pin "@fortawesome/free-solid-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-solid-svg-icons@6.0.0/index.es.js"
pin "flatpickr", to: "https://ga.jspm.io/npm:flatpickr@4.6.10/dist/flatpickr.js"
pin "flatpickr/dist/l10n/ja", to: "https://ga.jspm.io/npm:flatpickr@4.6.10/dist/l10n/ja.js"
pin "js-cookie", to: "https://ga.jspm.io/npm:js-cookie@3.0.1/dist/js.cookie.mjs"
pin "tabulator-tables", to: "https://ga.jspm.io/npm:tabulator-tables@5.1.0/dist/js/tabulator_esm.js"
pin_all_from "app/javascript/lib", under: "lib"
pin_all_from "app/javascript/controllers", under: "controllers"
