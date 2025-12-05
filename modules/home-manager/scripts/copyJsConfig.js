const fs = require('node:fs')
const path = require('node:path')
/** @type {{ [key: string]: string | undefined }} */
const linkMap = {
  'biome.jsonc': undefined,
  'jsconfig.json': undefined
}
for (let [name, filePath] of Object.entries(linkMap)) {
  filePath = filePath ?? name
  if (!fs.existsSync(path.join(process.argv[2] ?? '', name)))
    fs.symlinkSync(path.join('/persist/nixos', filePath), path.join(process.argv[2] ?? '', name))
}

/** @type {{ [key: string]: string | undefined }} */
const fileMap = {
  '.gitignore': 'jsConfig.gitignore'
}
for (let [name, filePath] of Object.entries(fileMap)) {
  filePath = filePath ?? name
  if (!fs.existsSync(path.join(process.argv[2] ?? '', name)))
    fs.copyFileSync(path.join('/persist/nixos', filePath), path.join(process.argv[2] ?? '', name))
}
