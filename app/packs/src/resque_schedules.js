const loadSchedules = () => {
  const field = document.getElementById('resque-schedules')
  if (!field) { return }

  document.querySelector('img.loading').classList.remove('d-none')
  window.fetch('/resque_schedules/schedule')
    .then(response => {
      if (!response.ok) {
        throw new Error(`${response.status} ${response.statusText}`)
      }
      return JSON.stringify(response, null, 4)
    })
    .then(json => { field.innerHTML = json })
    .catch(err => {
      field.innerHTML = 'An error occurred.'
      console.error('An error occurred. Message:', err)
    })
    .finally(() => document.querySelector('img.loading').classList.add('d-none'))
}

window.addEventListener('turbolinks:load', loadSchedules)
