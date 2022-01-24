const loadSchedules = () => {
  const field = document.getElementById('resque-schedules')
  if (!field) { return }

  document.querySelector('img.loading').classList.remove('d-none')
  window.fetch('/resque_schedules/schedule')
    .then(response => {
      if (!response.ok) {
        throw new Error(`${response.status} ${response.statusText}`)
      }
      return response.json()
    })
    .then(json => { field.innerHTML = JSON.stringify(json, null, 4) })
    .catch(err => {
      field.innerHTML = 'An error occurred.'
      console.error('An error occurred. Message:', err)
    })
    .finally(() => document.querySelector('img.loading').classList.add('d-none'))
}

window.addEventListener('turbo:load', loadSchedules)
