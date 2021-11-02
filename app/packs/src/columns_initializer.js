import { Tabulator, PageModule, ResizeColumnsModule, SortModule } from 'tabulator-tables'

Tabulator.registerModule([PageModule, SortModule, ResizeColumnsModule])

window.addEventListener('turbolinks:load', () => {
  if (document.URL.match(/candle_access/)) {
    new Tabulator('#candle-access-table', { // eslint-disable-line no-new
      height: 'auto',
      placeholder: 'No Data Set',
      layout: 'fitColumns'
    })
  }
})
