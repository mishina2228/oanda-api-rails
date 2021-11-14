const Shared = {}
Shared.getCsrfToken = () => {
  return document.getElementsByName('csrf-token')[0].content
}
Shared.getFormMethod = form => {
  let method = form.getAttribute('method')
  const children = form.childNodes
  for (let i = 0; i < children.length; i++) {
    if (children[i].tagName.toLowerCase() === 'input' && children[i].name === '_method') {
      method = children[i].value
      break
    }
  }
  return method.toUpperCase()
}
Shared.sendAction = (form, body = null, contentType = 'application/json') => {
  const url = form.getAttribute('action')

  return window.fetch(url, {
    method: Shared.getFormMethod(form),
    headers: {
      Accept: contentType,
      'Content-Type': contentType,
      'X-CSRF-Token': Shared.getCsrfToken()
    },
    body: body
  })
}

export { Shared }
