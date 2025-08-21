const path = require('node:path')
const fs = require('node:fs')

const folderPath = path.join(process.argv[1] ?? '', '..')

const items = []
for (const item of fs.readdirSync(folderPath)) {
  const [name, extension] = item.split('.')
  if (extension === 'nix') items.push(name)
}
console.log(
  `You have ${items.length} registered macro${items.length === 1 ? '' : 's'}:${items.map(item => `\n${item}`).join('')}`
)
