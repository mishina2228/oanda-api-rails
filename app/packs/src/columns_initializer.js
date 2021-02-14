import Tabulator from 'tabulator-tables'

window.addEventListener('turbolinks:load', () => {
  if (document.URL.match(/candle_access/)) {
    new Tabulator('#candle-access-table', {
      placeholder: 'No Data Set',
      layout: 'fitColumns'
    })
  }
})
