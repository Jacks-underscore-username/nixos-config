const path = require('node:path')
const fs = require('node:fs')

if (['-h', '--help'].some(str => process.argv.includes(str))) {
  console.log(
    ['Usage: lineCounter [OPTIONS]', '-h, --help: Shows this menu', '-t, --tree: Shows full output'].join('\n')
  )
  process.exit()
}

const badExtensions = [
  'jpg',
  'jpeg',
  'png',
  'gif',
  'bmp',
  'webp',
  'svg',
  'mp3',
  'wav',
  'aac',
  'flac',
  'ogg',
  'm4a',
  'mp4',
  'mov',
  'avi',
  'wmv',
  'flv',
  'webm',
  'mkv',
  'pdf',
  'doc',
  'docx',
  'xls',
  'xlsx',
  'ppt',
  'pptx',
  'zip',
  'rar',
  '7z',
  'tar',
  'gz',
  'bz2',
  'exe',
  'dll',
  'bin',
  'iso',
  'dmg',
  'apk',
  'jar',
  'swf',
  'obj',
  'fbx',
  'dae',
  'gltf',
  'blend',
  'psd',
  'ai',
  'indd',
  'sketch',
  'xd',
  'wav',
  'mid',
  'midi',
  'aiff',
  'wma',
  '3gp',
  'm4v',
  'webm'
].map(name => `.${name}`)

const badFolders = ['.git', 'node_modules']

const showTree = ['-t', '--tree'].some(str => process.argv.includes(str))

/**
 * @param {number} x
 * @returns {string}
 */
const s = x => (x === 1 ? '' : 's')

/**
 * @param {string} folder
 * @returns {{ lines: number, files: number, folders: number, logs: string[] }}
 */
const scan = folder => {
  let lines = 0
  let files = 0
  let folders = 0
  const logs = []
  for (const file of fs.readdirSync(folder)) {
    const filePath = path.join(folder, file)
    const stat = fs.statSync(filePath)
    if (stat.isDirectory() && !badFolders.includes(file)) {
      folders++
      const result = scan(filePath)
      logs.push(
        `${file} -> ${result.lines} line${s(result.lines)}, ${result.files} file${s(result.files)}, ${result.folders} folder${s(result.folders)}:`
      )
      logs.push(...result.logs.map(log => ` * ${log}`))
      lines += result.lines
      files += result.files
      folders += result.folders
    }
    if (stat.isFile() && !badExtensions.includes(path.extname(file))) {
      const size = fs.readFileSync(filePath, 'utf8').split('\n').length
      logs.push(`${file}: ${size} line${s(size)}`)
      lines += size
      files++
    }
  }
  return { lines, files, folders, logs }
}

const { lines, files, folders, logs } = scan(process.cwd())

console.log(`${lines} lines in ${files} files and ${folders} folders`)
if (showTree) console.log(logs.join('\n'))
