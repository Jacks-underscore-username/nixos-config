#!/usr/bin/env node

const blessed = require('blessed')
const { exec } = require('node:child_process')

// --- Configuration ---
const GIT_LOG_FORMAT = '%H%n%an%n%ad%n%s%n%b%n---COMMIT-END---' // Add a delimiter
const GIT_DIFF_COMMAND = 'git show --format=fuller ' // Command to get full diff for a commit

// --- Data Structures ---
let commits = []
let expandedCommits = new Set() // Stores hashes of expanded commits

// --- Blessed UI Elements ---
let screen
let commitList // A blessed list to display commits
let commitDetailBox // A box to show commit details/diff
let statusBox // A box to show status messages

// --- Utility Functions ---

/**
 * Parses the raw git log output into an array of commit objects.
 * @param {string} rawLog
 * @returns {Array<Object>}
 */
function parseGitLog(rawLog) {
  const commitStrings = rawLog.split('---COMMIT-END---\n').filter(Boolean) // Split by delimiter and filter empty
  return commitStrings
    .map(commitStr => {
      const lines = commitStr.trim().split('\n')
      if (lines.length < 4) {
        // Basic validation
        return null
      }
      const hash = lines[0]
      const author = lines[1]
      const date = lines[2]
      const subject = lines[3]
      const body = lines.slice(4).join('\n').trim() // Everything after subject is body

      return {
        hash,
        author,
        date,
        subject,
        body,
        isExpanded: false, // Initial state
        raw: commitStr // Store raw content for easier diff extraction later if needed
      }
    })
    .filter(Boolean)
}

/**
 * Renders the commit list in the blessed UI.
 */
function renderCommitList() {
  const items = []
  commits.forEach(commit => {
    const isExpanded = expandedCommits.has(commit.hash)
    const prefix = isExpanded ? '[ - ]' : '[ + ]'
    items.push(`${prefix} ${commit.subject} (${commit.author}, ${commit.date})`)

    if (isExpanded) {
      // Add more detail if expanded. This is simplified.
      // For actual diff, you'd fetch it here or on initial expand
      items.push(`  Hash: ${commit.hash}`)
      if (commit.body) {
        items.push(
          `  Body:\n${commit.body
            .split('\n')
            .map(line => `    ${line}`)
            .join('\n')}`
        )
      }
      // Placeholder for diff - real diff would be fetched async
      items.push(`  (Press 'd' for full diff)`)
      items.push(` `) // Blank line for spacing
    }
  })

  commitList.setItems(items)
  screen.render()
}

/**
 * Fetches the git log and initializes the UI.
 */
function fetchGitLog() {
  setStatus('Fetching git log...')
  exec(
    `git log --pretty=format:"${GIT_LOG_FORMAT}"`,
    { maxBuffer: 1024 * 1024 * 10 }, // Increase buffer for large logs
    (error, stdout, stderr) => {
      if (error) {
        setStatus(`Error fetching git log: ${error.message}`)
        console.error(`exec error: ${error}`)
        return
      }
      if (stderr) {
        setStatus(`Git log stderr: ${stderr}`)
        console.error(`git log stderr: ${stderr}`)
      }

      commits = parseGitLog(stdout)
      if (commits.length === 0) {
        setStatus('No commits found in this repository.')
        return
      }
      setStatus(`Found ${commits.length} commits. Use UP/DOWN to navigate, SPACE to expand/collapse, 'd' for diff.`)
      renderCommitList()
      commitList.focus()
      screen.render()
    }
  )
}

/**
 * Displays the full diff of the currently selected commit in a separate box.
 * @param {string} commitHash
 */
function showCommitDiff(commitHash) {
  setStatus(`Fetching diff for ${commitHash}...`)
  exec(`${GIT_DIFF_COMMAND} ${commitHash}`, { maxBuffer: 1024 * 1024 * 10 }, (error, stdout, stderr) => {
    if (error) {
      setStatus(`Error fetching diff: ${error.message}`)
      console.error(`exec error: ${error}`)
      commitDetailBox.setContent(`Error: ${error.message}`)
      return
    }
    if (stderr) {
      // stderr might contain warnings, but stdout will have the diff
      // setStatus(`Diff stderr: ${stderr}`);
    }
    commitDetailBox.setContent(stdout)
    screen.render()
    setStatus(`Diff for ${commitHash}. Press 'q' to close diff.`)
    commitDetailBox.focus() // Focus on diff box
  })
}

/**
 * Sets the content of the status bar.
 * @param {string} message
 */
function setStatus(message) {
  statusBox.setContent(`Status: ${message}`)
  screen.render()
}

// --- Initialize Blessed Screen ---
screen = blessed.screen({
  smartCSR: true, // Optimizes redraws
  title: 'T3 Git Log Viewer'
})

// --- Main Commit List ---
commitList = blessed.list({
  parent: screen,
  top: 0,
  left: 0,
  width: '100%',
  height: '80%', // Leave space for detail box and status
  label: ' Git Commits ',
  keys: true, // Enable arrow keys for navigation
  vi: true, // Enable vi keys (j/k)
  mouse: true, // Enable mouse for scrolling/clicking
  scrollable: true,
  border: 'line',
  style: {
    selected: {
      bg: 'blue'
    },
    item: {
      fg: 'white'
    },
    border: {
      fg: '#f0f0f0'
    },
    label: {
      fg: 'cyan'
    }
  },
  scrollbar: {
    ch: ' ',
    inverse: true
  }
})

// --- Commit Detail / Diff Box ---
commitDetailBox = blessed.box({
  parent: screen,
  top: '80%',
  left: 0,
  width: '100%',
  height: '15%', // Space for diff/details
  label: " Commit Details / Diff (Press 'q' to close) ",
  border: 'line',
  scrollable: true,
  keys: true,
  vi: true,
  mouse: true,
  scrollbar: {
    ch: ' ',
    inverse: true
  },
  style: {
    border: {
      fg: 'green'
    },
    label: {
      fg: 'magenta'
    }
  },
  content: "Select a commit and press 'd' for diff."
})

// --- Status Bar ---
statusBox = blessed.box({
  parent: screen,
  bottom: 0,
  left: 0,
  width: '100%',
  height: '5%',
  content: 'Loading...',
  style: {
    fg: 'yellow',
    bg: 'black'
  }
})

// --- Event Handling ---

// Quit on Ctrl+C
screen.key(['escape', 'C-c'], function (ch, key) {
  return process.exit(0)
})

// Handle 'q' to close diff or quit app if diff not open
screen.key('q', function (ch, key) {
  if (screen.focused === commitDetailBox) {
    commitDetailBox.setContent("Select a commit and press 'd' for diff.")
    commitList.focus() // Return focus to the list
    setStatus("Diff closed. Use UP/DOWN to navigate, SPACE to expand/collapse, 'd' for diff.")
    screen.render()
  } else {
    return process.exit(0)
  }
})

// Handle Spacebar for expanding/collapsing commits
commitList.on('select', function (item, index) {
  const actualCommitIndex = commits.findIndex(c => {
    // This is a bit tricky: find the actual commit object based on the blessed list index
    // We need to account for expanded content displacing indices
    let currentIndex = 0
    for (let i = 0; i < commits.length; i++) {
      if (currentIndex === index) return true // Found the commit header
      currentIndex++ // For the header line

      if (expandedCommits.has(commits[i].hash)) {
        currentIndex += 3 + (commits[i].body ? commits[i].body.split('\n').length : 0) // For expanded details
      }
      if (currentIndex > index) return false // Passed it
    }
    return false // Should not happen
  })

  if (actualCommitIndex !== -1) {
    const selectedCommit = commits[actualCommitIndex]
    if (expandedCommits.has(selectedCommit.hash)) {
      expandedCommits.delete(selectedCommit.hash)
    } else {
      expandedCommits.add(selectedCommit.hash)
    }
    renderCommitList()
    // Keep the selection on the same logical commit, adjusting for new height
    let newIndex = 0
    for (let i = 0; i < actualCommitIndex; i++) {
      newIndex++ // For the header line
      if (expandedCommits.has(commits[i].hash)) {
        newIndex += 3 + (commits[i].body ? commits[i].body.split('\n').length : 0)
      }
    }
    commitList.select(newIndex)
  }
})

// Handle 'd' key for diff
screen.key('d', function (ch, key) {
  if (screen.focused === commitList) {
    const selectedItemIndex = commitList.selected

    // Find the actual commit hash based on the selected item index
    let currentLine = 0
    let selectedCommitHash = null
    for (let i = 0; i < commits.length; i++) {
      const commit = commits[i]
      if (currentLine === selectedItemIndex) {
        selectedCommitHash = commit.hash
        break
      }
      currentLine++ // For the commit header line
      if (expandedCommits.has(commit.hash)) {
        currentLine += 3 + (commit.body ? commit.body.split('\n').length : 0) // Add lines for expanded content
      }
      if (currentLine > selectedItemIndex) {
        // We've gone past the selected line, meaning the selection
        // is likely on an expanded detail line, not a commit header.
        // In this case, we want the *previous* commit's hash.
        if (i > 0) {
          selectedCommitHash = commits[i - 1].hash
        }
        break
      }
    }

    if (selectedCommitHash) {
      showCommitDiff(selectedCommitHash)
    } else {
      setStatus('No commit selected or selection is on a non-commit line.')
    }
  }
})

// Focus the commit list on start
commitList.focus()

// Initial fetch and render
fetchGitLog()

// Render the screen
screen.render()
