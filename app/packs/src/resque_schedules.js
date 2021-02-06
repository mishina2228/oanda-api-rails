let resque_schedules = {};
resque_schedules.load_schedules = () => {
  const $field = $('#resque-schedules');
  if(!$field[0]) {
    return null;
  }
  $.ajax({
    url: '/resque_schedules/schedule',
    type: 'GET',
    beforeSend: () => {
      $('img.loading').removeClass('hide')
    }
  }).always((data) => {
    const pretty = JSON.stringify(data, null, 4);
    $field.html(pretty);
    $('img.loading').addClass('hide')
  })
};

$(document).on('turbolinks:load', (() => {
  resque_schedules.load_schedules();
}));
