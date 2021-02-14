import Tabulator from 'tabulator-tables'

$(document).on('turbolinks:load', () => {
  $('#candle-access').on('click', event => {
    $(event.currentTarget).prop('disabled', true)
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
    }).always((data) => {
      data = data.map(obj => {
        delete obj._attributes
        return obj
      })
      new Tabulator('#candle-access-table', {
        data: data,
        autoColumns: true,
        layout: 'fitColumns',
        placeholder: 'No Data Set',
        pagination: 'local',
        paginationSize: 10,
        paginationSizeSelector: [5, 10, 15, 20, 25, 30],
        tooltips: true
      })
      $('img.loading').addClass('d-none')
      $(event.currentTarget).prop('disabled', false)
    })
  })
})
