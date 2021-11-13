import { Tabulator, PageModule, ResizeColumnsModule, SortModule } from 'tabulator-tables'

Tabulator.registerModule([PageModule, SortModule, ResizeColumnsModule])

const initCandleAccessTable = () => {
  if (document.URL.match(/candle_access/)) {
    return new Tabulator('#candle-access-table', {
      height: 'auto',
      placeholder: 'No Data Set',
      layout: 'fitColumns'
    })
  }
}

window.addEventListener('turbolinks:load', initCandleAccessTable)
