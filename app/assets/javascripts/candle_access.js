$(document).on('turbolinks:load', (() => {
  $('#candle-access').on('click', event => {
    $(event.currentTarget).prop('disabled', true);
    const $form = $(event.currentTarget).parents('form');
    const $result_field = $('.candle-access.result.columns');
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
      },
      beforeSend: () => {
        $('img.loading').removeClass('hide')
      }
    }).done((data) => {
      console.log('SUCCESS');
      console.log(data);
    }).fail((data) => {
      console.log('FAIL');
      console.log(data);
    }).always((data) => {
      data = data.map(obj => {
        delete obj._attributes;
        return obj;
      });
      $result_field.columns('destroy');
      $result_field.columns({
        data: data,
        size: 10
      });
      $('img.loading').addClass('hide');
      $(event.currentTarget).prop('disabled', false);
    })
  })
}));
