const path = require('node:path')
const fs = require('node:fs')

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
    if (stat.isDirectory() && !badFolders.includes(file)) scan(filePath)
    if (stat.isFile() && !badExtensions.includes(path.extname(file))) {
      lines += fs.readFileSync(filePath, 'utf8').split('\n').length
      files++
    }
  }
}

scan(process.cwd())

console.log(`${lines} lines in ${files} files and ${folders} folders`)
