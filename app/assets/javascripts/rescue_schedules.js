$(document).on('turbolinks:load', (function () {
  const $field = $('#resque-schedules');
  $.ajax({
    url: '/resque_schedules/schedule',
    type: 'GET',
    beforeSend: function () {
      $('img.loading').removeClass('hide')
    }
  }).done(() => {
    console.log('CONNECTION SUCCEEDED');
  }).fail(() => {
    console.log('CONNECTION FAILED');
    console.log('[FAIL] Could not acquire Resque Schedules Information.');
  }).always((data) => {
    const pretty = JSON.stringify(data, null, 4);
    $field.html(pretty);
    $('img.loading').addClass('hide')
  })
}));
