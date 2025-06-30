const path = require('node:path')
const fs = require('node:fs')

let lines = 0
let files = 0
let folders = 0

/**
 * @param {string} folder
 */
const scan = folder => {
  folders++
  for (const file of fs.readdirSync(folder)) {
    const filePath = path.join(folder, file)
    const stat = fs.statSync(filePath)
    if (stat.isDirectory()) scan(filePath)
    if (stat.isFile()) {
      lines += fs.readFileSync(filePath, 'utf8').split('\n').length
      files++
    }
  }
}

scan(process.cwd())

console.log(`${lines} lines in ${files} files and ${folders} folders`)
