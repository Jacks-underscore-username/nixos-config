const { execSync } = require('node:child_process')
const fs = require('node:fs')
const path = require('node:path')

const statePath = path.resolve(process.argv[1], '../moveWindow.state')

const timeout = 10_000

const focusedWindow = execSync('hyprctl activewindow | grep "pid: " | awk \'{print $2}\'').toString().trim()
const focusedWorkspace = execSync(
  "hyprctl activeworkspace | grep \"workspace ID\" | awk '{print $3}' | head -n 1 | sed 's/.*\\([0-9]\\)$/\\1/'"
)
  .toString()
  .trim()

const now = Date.now()
if (fs.existsSync(statePath)) {
  const [time, window] = fs.readFileSync(statePath, 'utf-8').split(' ')
  if (now - Number.parseInt(time) <= timeout) {
    execSync(`hyprctl dispatch movetoworkspace "${focusedWorkspace},pid:${window}"`)
    fs.rmSync(statePath)
  } else fs.writeFileSync(statePath, `${now} ${focusedWindow}`)
} else fs.writeFileSync(statePath, `${now} ${focusedWindow}`)
