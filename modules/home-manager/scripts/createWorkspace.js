const { execSync } = require('node:child_process')

const workspaceIDs = execSync('hyprctl workspaces')
  .toString()
  .split('workspace ID ')
  .filter(x => x.length)
  .map(x => x.match(/^[0-9]+/))

const nextID = workspaceIDs.reduce((prev, x) => Math.max(prev, Number.parseInt(x?.[0] ?? '0')), 0) + 1

execSync(`hyprctl dispatch workspace ${nextID}`)
