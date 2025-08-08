#!/usr/bin/env node

const blessed = require('blessed')
const { exec } = require('child_process')

// --- Configuration ---
const GIT_LOG_FORMAT = '%H%n%an%n%ad%n%s%n%b%n' // Removed delimiter here, will rely on parsing --numstat output
const COMMIT_DELIMITER = '---COMMIT-END---' // Custom delimiter to simplify splitting full output

// --- Data Structures ---
let commits = []
let expandedCommits = new Set() // Stores hashes of expanded commits
let selectedFile = {
  commitHash: null,
  filePath: null
} // Tracks the currently selected file for diffing

// --- Blessed UI Elements ---
let screen
let commitList // A blessed list to display commits and their changed files
let commitDetailBox // A box to show specific file diffs or full commit diffs
let statusBox // A box to show status messages

// --- Utility Functions ---

/**
 * Parses the raw git log output (including --numstat) into an array of commit objects.
 * This is more complex due to interspersed file stats.
 * @param {string} rawLog
 * @returns {Array<Object>}
 */
function parseGitLog(rawLog) {
  const lines = rawLog.split('\n')
  const parsedCommits = []
  let currentCommit = null
  let inFilesSection = false

  for (const line of lines) {
    if (line.startsWith('commit ') && line.length === 47) {
      // New commit starts (e.g., "commit e1c4a0b2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8")
      if (currentCommit) {
        parsedCommits.push(currentCommit)
      }
      currentCommit = {
        hash: line.substring(7),
        author: '',
        date: '',
        subject: '',
        body: '',
        filesChanged: [],
        isExpanded: false
      }
      inFilesSection = false
    } else if (line.startsWith('Author:')) {
      currentCommit.author = line.substring(8).trim()
    } else if (line.startsWith('Date:')) {
      currentCommit.date = line.substring(8).trim()
    } else if (line.trim().length > 0 && !currentCommit.subject) {
      // The first non-empty, non-header line is the subject
      currentCommit.subject = line.trim()
    } else if (
      (currentCommit && line.match(/^\d+\t\d+\t.+$/)) ||
      line.match(/^-+\t-+\t.+$/) // Numstat line (additions, deletions, file path)
    ) {
      inFilesSection = true
      const parts = line.split('\t')
      if (parts.length === 3) {
        currentCommit.filesChanged.push({
          additions: parts[0],
          deletions: parts[1],
          path: parts[2]
        })
      }
    } else if (currentCommit && !inFilesSection && line.trim().length > 0) {
      // This is part of the body
      if (!currentCommit.body) {
        currentCommit.body = line.trim()
      } else {
        currentCommit.body += `\n${line.trim()}`
      }
    } else if (line.trim().length === 0 && currentCommit && !inFilesSection) {
      // Empty line after headers but before body or files, or between body lines
      if (!currentCommit.body) {
        // If body hasn't started, skip
        // Do nothing, this is just empty spacing
      } else {
        // If body has started, treat as part of body
        currentCommit.body += `\n` // Add a newline to preserve formatting
      }
    } else if (currentCommit && line.trim().length === 0 && inFilesSection) {
      // Empty line after files section, indicates end of commit block
      inFilesSection = false
    }
  }

  if (currentCommit) {
    parsedCommits.push(currentCommit)
  }

  // A second pass to ensure the body captures everything after the subject and before files
  parsedCommits.forEach(commit => {
    const rawCommitBlock = rawLog.substring(rawLog.indexOf(commit.hash) - 7) // Find where this commit starts
    const rawLines = rawCommitBlock.split('\n')

    let inSubject = false
    let inBody = false
    let tempBody = []
    for (const line of rawLines) {
      if (line.includes(commit.subject) && !inSubject) {
        inSubject = true
        continue // Skip the subject line itself
      }
      if (inSubject && !line.startsWith('    ') && line.trim().length === 0) {
        // Empty line after subject, potentially before body or files
        continue
      }

      if (inSubject && line.startsWith('    ')) {
        // Body lines usually indented by 4 spaces
        tempBody.push(line.substring(4))
        inBody = true
      } else if (inBody && (line.match(/^\d+\t\d+\t.+$/) || line.match(/^-+\t-+\t.+$/))) {
        // Reached file section
        break
      } else if (inBody && line.trim().length === 0) {
        tempBody.push('') // Preserve empty lines in body
      } else if (inBody && !line.startsWith('    ') && line.trim().length > 0 && !line.startsWith('commit')) {
        // A non-indented line after body started but not a file stat or new commit
        // This might be more complex body lines or something unexpected.
        // For now, assume it's part of the body if it's not a stat.
        tempBody.push(line.trim())
      }
    }
    commit.body = tempBody.join('\n').trim()
  })

  return parsedCommits
}

/**
 * Renders the commit list in the blessed UI.
 */
function renderCommitList() {
  const items = []
  commits.forEach(commit => {
    const isExpanded = expandedCommits.has(commit.hash)
    const prefix = isExpanded ? '[ - ]' : '[ + ]'
    items.push(`${prefix} ${commit.subject} (^ ${commit.author}, ${commit.date})`)

    if (isExpanded) {
      if (commit.body) {
        items.push(
          `  ${commit.body.split('\n')[0].substring(0, 70)}${commit.body.split('\n')[0].length > 70 ? '...' : ''}`
        ) // First line of body
      } else {
        items.push(`  (No commit message body)`)
      }

      if (commit.filesChanged.length > 0) {
        items.push(`  Changed files:`)
        commit.filesChanged.forEach(file => {
          const isSelectedFile = selectedFile.commitHash === commit.hash && selectedFile.filePath === file.path
          const selectedPrefix = isSelectedFile ? ' >' : '  '
          items.push(
            `    ${selectedPrefix} ${file.additions.padStart(3)} + ${file.deletions.padStart(3)} - ${file.path}`
          )
        })
      } else {
        items.push(`  (No files changed)`)
      }
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
  setStatus('Fetching git log with file stats...')
  exec(
    `git log --pretty=format:"${GIT_LOG_FORMAT}commit %H" --numstat`, // Note: "commit %H" at end to make parsing easier for next commit block
    { maxBuffer: 1024 * 1024 * 50 }, // Increase buffer for large logs/diffs
    (error, stdout, stderr) => {
      if (error) {
        setStatus(`Error fetching git log: ${error.message}`)
        console.error(`exec error: ${error}`)
        return
      }
      if (stderr) {
        // stderr might contain warnings or other non-fatal info,
        // it's usually fine if stdout contains the data.
        // setStatus(`Git log stderr: ${stderr}`);
        console.error(`git log stderr: ${stderr}`)
      }

      commits = parseGitLog(stdout)
      if (commits.length === 0) {
        setStatus('No commits found in this repository.')
        return
      }
      setStatus(
        `Found ${commits.length} commits. Use UP/DOWN to navigate, SPACE to expand/collapse commit, ENTER to view file diff.`
      )
      renderCommitList()
      commitList.focus()
      screen.render()
    }
  )
}

/**
 * Displays the full diff of a specific file for a commit.
 * If no file path is provided, shows the full commit diff.
 * @param {string} commitHash
 * @param {string|null} filePath
 */
function showDiff(commitHash, filePath = null) {
  let command
  let label

  if (filePath) {
    // To get the diff of a specific file between *this commit* and its *parent*
    // git diff <parent_hash> <this_hash> -- <file_path>
    command = `git diff ${commitHash}^ ${commitHash} -- ${filePath}`
    label = ` Diff for ${filePath} in ${commitHash.substring(0, 7)} `
  } else {
    // To get the full diff for a commit (relative to its parent)
    command = `git show ${commitHash}`
    label = ` Full Diff for ${commitHash.substring(0, 7)} `
  }

  setStatus(`Fetching diff for ${filePath || commitHash.substring(0, 7)}...`)
  commitDetailBox.setLabel(label)

  exec(
    command,
    { maxBuffer: 1024 * 1024 * 50 }, // Large buffer for diffs
    (error, stdout, stderr) => {
      if (error) {
        setStatus(`Error fetching diff: ${error.message}`)
        console.error(`exec error: ${error}`)
        commitDetailBox.setContent(`Error: ${error.message}`)
        return
      }
      if (stderr) {
        // This can sometimes contain non-fatal warnings
        // setStatus(`Diff stderr: ${stderr}`);
      }
      commitDetailBox.setContent(stdout)
      screen.render()
      setStatus(`Diff loaded. Press 'q' to close diff.`)
      commitDetailBox.focus() // Focus on diff box
    }
  )
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
  label: ' Git Commits and Files (UP/DOWN, SPACE, ENTER, q) ',
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
  label: " Diff View (Press 'q' to close) ",
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
  content: 'Select a commit and expand it to see files. Press ENTER on a file to see its diff.'
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

// Quit on Ctrl+C or Escape
screen.key(['escape', 'C-c'], function (ch, key) {
  return process.exit(0)
})

// Handle 'q' to close diff or quit app if diff not open
screen.key('q', function (ch, key) {
  if (screen.focused === commitDetailBox) {
    commitDetailBox.setContent('Select a commit and expand it to see files. Press ENTER on a file to see its diff.')
    commitDetailBox.setLabel(" Diff View (Press 'q' to close) ")
    commitList.focus() // Return focus to the list
    setStatus('Diff closed. Use UP/DOWN to navigate, SPACE to expand/collapse, ENTER for file diff.')
    screen.render()
  } else {
    return process.exit(0)
  }
})

// Handle Spacebar for expanding/collapsing commits
// Handle Enter for viewing file diffs
commitList.on('select item', function (item, index) {
  // Determine if it's a commit header or a file line
  let currentCommitIndex = -1
  let currentLineOffset = 0
  let foundCommit = null

  for (let i = 0; i < commits.length; i++) {
    const commit = commits[i]
    if (currentLineOffset === index) {
      // This is a commit header
      currentCommitIndex = i
      foundCommit = commit
      break
    }
    currentLineOffset++ // For the header line

    if (expandedCommits.has(commit.hash)) {
      currentLineOffset++ // For the body first line
      currentLineOffset++ // For "Changed files:" line
      currentLineOffset += commit.filesChanged.length // For each file line
      currentLineOffset++ // For the blank line
    }

    if (currentLineOffset > index) {
      // The selected line is within the expanded details of the current commit
      // This means the "actual" commit we're interested in is `commit`
      currentCommitIndex = i
      foundCommit = commit
      break
    }
  }

  if (foundCommit) {
    if (commitList.selected === index) {
      // Check if this is the actually selected item being triggered by 'select'
      // If it's a commit header, toggle expansion
      if (item.content.startsWith('[ + ]') || item.content.startsWith('[ - ]')) {
        if (expandedCommits.has(foundCommit.hash)) {
          expandedCommits.delete(foundCommit.hash)
          selectedFile = { commitHash: null, filePath: null } // Deselect file when collapsing commit
        } else {
          expandedCommits.add(foundCommit.hash)
        }
        renderCommitList()
        // Try to re-select the original commit header after re-render
        let newIndex = 0
        for (let i = 0; i < currentCommitIndex; i++) {
          newIndex++ // For the header line
          if (expandedCommits.has(commits[i].hash)) {
            newIndex += 3 + commits[i].filesChanged.length + 1 // Body, "Changed files", files, blank
          }
        }
        commitList.select(newIndex)
      } else {
        // It's a file line or body line within an expanded commit
        const lineContent = item.content.trim()
        const fileMatch = lineContent.match(/^(\d+\s*\+\s*\d+\s*-\s*)(.*)$/)
        if (fileMatch) {
          const filePath = fileMatch[2].trim()
          selectedFile = {
            commitHash: foundCommit.hash,
            filePath: filePath
          }
          renderCommitList() // Re-render to show '>'
          setStatus(`File selected: ${filePath}. Press ENTER to view diff.`)
        } else {
          // If it's not a file line, clear selected file
          selectedFile = { commitHash: null, filePath: null }
          renderCommitList()
          setStatus(`Commit line selected. Press SPACE to expand/collapse.`)
        }
      }
    }
  }
})

// Handle Enter key (for diffing a selected file)
screen.key('enter', function (ch, key) {
  if (screen.focused === commitList) {
    if (selectedFile.commitHash && selectedFile.filePath) {
      showDiff(selectedFile.commitHash, selectedFile.filePath)
    } else {
      // If no file is specifically selected, but a commit header is focused and expanded
      // we can show the full commit diff
      let currentCommitIndex = -1
      let currentLineOffset = 0

      for (let i = 0; i < commits.length; i++) {
        const commit = commits[i]
        if (currentLineOffset === commitList.selected) {
          // This is a commit header line
          currentCommitIndex = i
          break
        }
        currentLineOffset++ // For the header line

        if (expandedCommits.has(commit.hash)) {
          currentLineOffset++ // For the body first line
          currentLineOffset++ // For "Changed files:" line
          currentLineOffset += commit.filesChanged.length // For each file line
          currentLineOffset++ // For the blank line
        }

        if (currentLineOffset > commitList.selected) {
          // The selected line is within the expanded details of the current commit,
          // but not a file line. This means it's the commit we want to show full diff for.
          currentCommitIndex = i
          break
        }
      }

      if (currentCommitIndex !== -1) {
        showDiff(commits[currentCommitIndex].hash) // Show full commit diff
      } else {
        setStatus('Select a file within an expanded commit or a commit header to view diff.')
      }
    }
  }
})

// Initial fetch and render
fetchGitLog()

// Render the screen
screen.render()
