const { execSync } = require('node:child_process')

let lastValue = ''
const update = () => {
  const value = execSync('hyprctl activewindow').toString()
  if (value !== lastValue) {
    console.clear()
    console.log(value)
    lastValue = value
  }
  setTimeout(update, 100)
}
update()
