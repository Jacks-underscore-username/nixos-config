const fs = require('node:fs')
const path = require('node:path')
const fileMap = {
  'biome.jsonc': undefined,
  'jsconfig.json': undefined,
  '.gitignore': 'jsConfig.gitignore'
}
for (let [name, filePath] of Object.entries(fileMap)) {
  filePath = filePath ?? name
  if (!fs.existsSync(path.join(process.argv[2] ?? '', name)))
    fs.symlinkSync(path.join('/persist/nixos', name), path.join(process.argv[2] ?? '', filePath))
}
