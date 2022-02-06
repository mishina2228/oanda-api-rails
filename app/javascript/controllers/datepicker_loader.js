import flatpickr from 'flatpickr'
import { Japanese } from 'flatpickr/dist/l10n/ja'

const localeDict = {
  en: null,
  ja: Japanese
}

window.addEventListener('turbo:load', () => {
  const locale = document.getElementsByTagName('body')[0].getAttribute('data-locale')
  flatpickr('.datetime-picker', {
    allowInput: true,
    altFormat: 'Y-m-dTH:i:S+09:00',
    altInput: true,
    enableTime: true,
    dateFormat: 'Z',
    locale: localeDict[locale]
  })
})
