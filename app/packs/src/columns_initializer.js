import Tabulator from 'tabulator-tables'

window.addEventListener('turbolinks:load', () => {
  if (document.URL.match(/candle_access/)) {
    new Tabulator('#candle-access-table', { // eslint-disable-line no-new
      placeholder: 'No Data Set',
      layout: 'fitColumns'
    })
  }
})
