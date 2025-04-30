const { execSync } = require('node:child_process')
const fs = require('node:fs')
const path = require('node:path')

const statePath = path.resolve(process.argv[1], '../moveWorkspace.state')

const timeout = 10_000

const focusedWorkspace = execSync(
  "hyprctl activeworkspace | grep \"workspace ID\" | awk '{print $3}' | head -n 1 | sed 's/.*\\([0-9]\\)$/\\1/'"
)
  .toString()
  .trim()
const focusedMonitor = execSync('hyprctl activeworkspace | grep "monitorID" | awk \'{print $2}\'').toString().trim()

const now = Date.now()
if (fs.existsSync(statePath)) {
  const [time, workspace, monitor] = fs.readFileSync(statePath, 'utf-8').split(' ')
  console.log(focusedWorkspace, focusedMonitor, workspace, monitor)
  if (now - Number.parseInt(time) <= timeout) {
    if (monitor !== focusedMonitor) execSync(`hyprctl dispatch moveworkspacetomonitor ${workspace} ${focusedMonitor}`)
    execSync(`hyprctl dispatch workspace ${workspace}`)
    fs.rmSync(statePath)
  } else fs.writeFileSync(statePath, `${now} ${focusedWorkspace} ${focusedMonitor}`)
} else fs.writeFileSync(statePath, `${now} ${focusedWorkspace} ${focusedMonitor}`)
