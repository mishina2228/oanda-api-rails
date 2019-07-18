$(document).on('turbolinks:load', (function () {
  $('#candle-access').on('click', function () {
    const $form = $(this).parents('form');
    const $result_field = $('code.candle-access.result');
    $.ajax({
      url: $form.attr('action'),
      type: 'POST',
      data: {
        '_method': 'PUT',
        'candle_access': {
          'candle_format': $form.find('#candle_access_candle_format').val(),
          'granularity': $form.find('#candle_access_granularity').val(),
          'instrument': $form.find('#candle_access_instrument').val(),
          'count': $form.find('#candle_access_count').val(),
          'start': $form.find('#candle_access_start').val()
        }
      }
    }).done((data) => {
      console.log(data);
    }).fail((data) => {
      console.log(data);
    }).always((data) => {
      $result_field.html(data);
    })
  })
}));
