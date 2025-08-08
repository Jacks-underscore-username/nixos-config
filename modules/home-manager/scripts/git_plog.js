const blessed = require('blessed')
const { execSync, exec } = require('node:child_process')

const GIT_LOG_MARKER = '---COMMIT-START---'
const GIT_LOG_FORMAT = `${GIT_LOG_MARKER}%n%H%n%an%n%ad%n%s%n%b%n`

const getRepoName = () => {
  try {
    const remote = execSync('git remote').toString().split('\n')?.[0]?.trim()
    if (remote) {
      const rawName = execSync(`git remote show ${remote}`).toString()
      const match = rawName.split('\n')[1].match(/\/([a-zA-Z0-9_-]+)(?:\.git)?$/)
      return match?.[1] || ''
    }
  } catch (e) {}
  return ''
}
const repoName = getRepoName()

const rawLog = execSync(`git log --pretty=format:"${GIT_LOG_FORMAT}" --numstat`, {
  maxBuffer: 1024 * 1024 * 50
}).toString()
const rawCommits = rawLog.split(GIT_LOG_MARKER).filter(rawCommit => rawCommit.trim().length)

const commits = rawCommits.map((rawCommit, index) => {
  const lines = rawCommit
    .trim()
    .split('\n')
    .filter(line => line.trim().length > 0)

  const hash = lines.shift() ?? ''
  const author = lines.shift() ?? ''
  const fullDate = lines.shift() ?? ''
  const message = lines.shift() ?? ''

  /** @type {string[]} */
  const bodyLines = []
  const changes = []
  let inBody = false
  let inChanges = false

  for (const line of lines) {
    if (line.match(/^\d+\t\d+\t.+$/) || line.match(/^-+\t-+\t.+$/)) {
      inChanges = true
      inBody = false
      const match = line.match(/^(.+?)\t(.+?)\t(.+)$/)
      if (match) changes.push({ a: match[1], b: match[2], path: match[3] })
    } else if (line.trim().length > 0) {
      if (!inChanges) {
        bodyLines.push(line.startsWith('    ') ? line.substring(4) : line)
        inBody = true
      }
    } else if (inBody) bodyLines.push('')
  }

  return {
    hash,
    author,
    fullDate,
    message,
    body: bodyLines.join('\n').trim(),
    changes,
    open: false
  }
})

function generateListItems() {
  /** @type {string[]} */
  const items = []
  for (const commit of commits) {
    const prefix = commit.open ? '{red-fg}[-]{/red-fg}' : '{green-fg}[+]{/green-fg}'
    items.push(`${prefix} {white-fg}{bold}${commit.hash.substring(0, 7)}{/bold}: ${commit.message}{/white-fg}`)

    if (commit.open) {
      items.push(`  {blue-fg}Author:{/blue-fg} {white-fg}${commit.author}{/white-fg}`)
      items.push(`  {blue-fg}Date:{/blue-fg} {white-fg}${commit.fullDate}{/white-fg}`)

      if (commit.body) {
        items.push('  {green-fg}Body:{/green-fg}')
        for (const line of commit.body.split('\n')) items.push(`    {light-white-fg}${line}{/light-white-fg}`)
      }
      if (commit.changes.length > 0) {
        items.push('  {yellow-fg}Changes:{/yellow-fg}')
        for (const change of commit.changes)
          items.push(
            `    {green-fg}+${change.a}{/green-fg} {red-fg}-${change.b}{/red-fg} {cyan-fg}${change.path}{/cyan-fg}`
          )
      } else items.push('  {yellow-fg}(No files changed){/yellow-fg}')

      items.push('')
    }
  }
  return items
}

const screen = blessed.screen({
  smartCSR: true
})

screen.key(['escape', 'q'], () => {
  if (!diffWindow.hidden) {
    diffWindow.hide()
    list.focus()
    screen.render()
  } else return process.exit(0)
})

screen.key('C-c', () => process.exit(0))

const list = blessed.list({
  parent: screen,
  top: 0,
  left: 0,
  tags: true,
  label: ` Git repo${repoName.length ? ` "${repoName}"` : ''} logs`,
  items: generateListItems(),
  keys: true,
  vi: true,
  mouse: true,
  scrollable: true,
  border: 'line',
  style: {
    selected: {
      bg: '#454545'
    },
    item: {
      fg: '#fff'
    },
    border: {
      fg: '#fff'
    }
  },
  scrollbar: {
    ch: ' '
  }
})

const diffWindow = blessed.list({
  parent: screen,
  top: 0,
  left: 0,
  tags: true,
  keys: true,
  vi: true,
  mouse: true,
  scrollable: true,
  border: 'line',
  style: {
    selected: {
      bg: '#454545'
    },
    item: {
      fg: '#fff'
    },
    border: {
      fg: 'cyan'
    }
  },
  scrollbar: {
    ch: ' '
  },
  hidden: true
})

const updateListAndRender = () => {
  // @ts-expect-error
  const currentSelected = list.selected
  const currentChildBase = list.childBase

  list.setItems(generateListItems())

  list.select(currentSelected)
  list.childBase = currentChildBase

  screen.render()
}

/**
 * @param {number} selectedIndex
 * @returns {{commit: typeof commits[0], change?: typeof commits[0]['changes'][0]} | undefined}
 */
const getSelectedData = selectedIndex => {
  let currentDisplayIndex = 0
  for (let i = 0; i < commits.length; i++) {
    const commit = commits[i]
    if (currentDisplayIndex === selectedIndex) return { commit }
    currentDisplayIndex++
    if (commit.open) {
      currentDisplayIndex += 2
      if (commit.body) {
        currentDisplayIndex++
        currentDisplayIndex += commit.body.split('\n').length
      }
      currentDisplayIndex++
      for (const change of commit.changes) {
        if (currentDisplayIndex === selectedIndex) return { commit, change }

        currentDisplayIndex++
      }
      currentDisplayIndex++
    }
    if (currentDisplayIndex > selectedIndex) return { commit }
  }
  return undefined
}

/**
 * @param {string} commitHash
 * @param {string} filePath
 */
const showFileDiff = (commitHash, filePath) => {
  const command = `git diff --minimal --color ${commitHash}^ ${commitHash} -- ${filePath}`

  diffWindow.setLabel(` File Diff: {cyan-fg}${filePath}{/cyan-fg} in {bold}${commitHash.substring(0, 7)}{/bold} `)
  diffWindow.setContent('{center}Loading diff...{/center}')
  diffWindow.show()
  screen.render()
  diffWindow.focus()

  exec(command, (error, stdout, stderr) => {
    if (error)
      diffWindow.setContent(
        `{red-fg}Error fetching diff for command:\n{/red-fg}{white-fg}${command}{/white-fg}\n{red-fg}Error: ${error.message}{/red-fg}\n{yellow-fg}Stderr: ${stderr}{/yellow-fg}`
      )
    else diffWindow.setItems(stdout.split('\n'))
    diffWindow.focus()
    screen.render()
  })
}
list.key(['enter', 'space'], () => {
  // @ts-expect-error
  const selectedIndex = list.selected
  const selectedData = getSelectedData(selectedIndex)

  if (!selectedData) return

  if (selectedData.change) {
    showFileDiff(selectedData.commit.hash, selectedData.change.path)
  } else {
    selectedData.commit.open = !selectedData.commit.open
    updateListAndRender()
  }
})

screen.append(list)
screen.append(diffWindow)
list.focus()
screen.render()
