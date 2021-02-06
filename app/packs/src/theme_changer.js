$(document).on('turbolinks:load', () => {
  $('button.dark-mode-toggle').click(() => {
    change_theme();
  });
});

function change_theme() {
  const Cookies = require('js-cookie')
  const body = $('body');
  body.toggleClass('dark_mode');
  const dark_mode_val = body.hasClass('dark_mode') ? 'isActive' : 'notActive';
  Cookies.set('dark_mode', dark_mode_val);
}
