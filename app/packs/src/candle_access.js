import { Shared } from './shared'
import { Tabulator, PageModule, ResizeColumnsModule, SortModule } from 'tabulator-tables'

Tabulator.registerModule([PageModule, ResizeColumnsModule, SortModule])

window.addEventListener('turbolinks:load', () => {
  document.getElementById('candle-access')?.addEventListener('click', event => {
    document.querySelector('img.loading').classList.remove('d-none')
    document.getElementById('candle-access').setAttribute('disabled', 'disabled')

    const form = event.currentTarget.closest('form')
    const payload = JSON.stringify({
      candle_access: {
        candle_format: document.getElementById('candle_access_candle_format').value,
        granularity: document.getElementById('candle_access_granularity').value,
        instrument: document.getElementById('candle_access_instrument').value,
        count: document.getElementById('candle_access_count').value,
        start: document.getElementById('candle_access_start').value
      }
    })
    Shared.sendAction(form, payload)
      .then(response => {
        if (!response.ok) {
          throw new Error(`${response.status} ${response.statusText}`)
        }
        return response.json()
      })
      .then(json => {
        json = json.map(obj => {
          delete obj._attributes
          return obj
        })
        return new Tabulator('#candle-access-table', {
          data: json,
          autoColumns: true,
          placeholder: 'No Data Set',
          pagination: true,
          paginationSize: 10,
          paginationSizeSelector: [5, 10, 15, 20, 25, 30],
          layout: 'fitColumns',
          columnDefaults: { resizable: 'header', tooltip: true }
        })
      })
      .catch(err => {
        window.alert('Unable to access the API. Please try again later.')
        console.error('Unable to access the API. Please try again later. Message:', err)
      })
      .finally(() => {
        document.querySelector('img.loading').classList.add('d-none')
        document.getElementById('candle-access').removeAttribute('disabled')
      })
  })
})
