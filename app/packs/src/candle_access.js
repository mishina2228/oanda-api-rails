import { Tabulator, PageModule, ResizeColumnsModule, SortModule } from 'tabulator-tables'

Tabulator.registerModule([PageModule, ResizeColumnsModule, SortModule])

$(document).on('turbolinks:load', () => {
  $('#candle-access').on('click', event => {
    event.currentTarget.setAttribute('disabled', 'disabled')
    const $form = $(event.currentTarget).parents('form')
    $.ajax({
      url: $form.attr('action'),
      type: 'POST',
      data: {
        _method: 'PUT',
        candle_access: {
          candle_format: $form.find('#candle_access_candle_format').val(),
          granularity: $form.find('#candle_access_granularity').val(),
          instrument: $form.find('#candle_access_instrument').val(),
          count: $form.find('#candle_access_count').val(),
          start: $form.find('#candle_access_start').val()
        }
      },
      beforeSend: () => {
        $('img.loading').removeClass('d-none')
      }
    }).done(data => {
      data = data.map(obj => {
        delete obj._attributes
        return obj
      })
      new Tabulator('#candle-access-table', { // eslint-disable-line no-new
        data: data,
        autoColumns: true,
        placeholder: 'No Data Set',
        pagination: true,
        paginationSize: 10,
        paginationSizeSelector: [5, 10, 15, 20, 25, 30],
        layout: 'fitColumns',
        columnDefaults: { resizable: 'header', tooltip: true }
      })
    }).fail(() => {
      window.alert('Unable to access the API. Please try again later.')
    }).always(() => {
      document.querySelector('img.loading').classList.add('d-none')
      event.currentTarget.removeAttribute('disabled')
    })
  })
})
