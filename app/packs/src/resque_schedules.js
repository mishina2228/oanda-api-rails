const loadSchedules = () => {
  const $field = $('#resque-schedules')
  if (!$field[0]) {
    return null
  }
  $.ajax({
    url: '/resque_schedules/schedule',
    type: 'GET',
    beforeSend: () => {
      $('img.loading').removeClass('d-none')
    }
  }).always((data) => {
    const pretty = JSON.stringify(data, null, 4)
    $field.html(pretty)
    $('img.loading').addClass('d-none')
  })
}

$(document).on('turbolinks:load', () => {
  loadSchedules()
})
