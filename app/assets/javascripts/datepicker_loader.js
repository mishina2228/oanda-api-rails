$(document).on('turbolinks:load', (() => {
  $('.datetime-picker').datetimepicker({
    format: 'YYYY-MM-DDTHH:mm:ssZ',
    locale: 'ja'
  });
  $('.date-picker').datetimepicker({
    format: 'YYYY-MM-DD',
    locale: 'ja'
  });
  $('.month-picker').datetimepicker({
    format: 'YYYY-MM',
    locale: 'ja',
    viewMode: 'months'
  });
  $('.year-picker').datetimepicker({
    format: 'YYYY',
    locale: 'ja',
    viewMode: 'years'
  });
}));
