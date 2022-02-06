import { dom, library } from '@fortawesome/fontawesome-svg-core'
import { faCalendar } from '@fortawesome/free-solid-svg-icons'
import { faCheckSquare, faSquare } from '@fortawesome/free-regular-svg-icons'

library.add(
  faCalendar,
  faCheckSquare, faSquare
)

dom.watch()
