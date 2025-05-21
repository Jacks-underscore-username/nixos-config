const fs = require('node:fs')
const path = require('node:path')

fs.cpSync

const statePath = path.resolve(process.argv[1], '../compareDir.state')
const resultPath = path.resolve(process.argv[1], '../compareDir.result')

const root = path.resolve(process.argv[2])

const record = {}

const excludes = [/.*\.git$/, /^node_modules*/]

const fullExcludes = [/^\/proc\/.*/, /^\/sys\/.*/, /^\/tmp\/.*/, /^\/run\/.*/, /^\/dev\/.*/]

const scan = (folder, parentRecord) => {
  try {
    for (item of fs.readdirSync(folder)) {
      const newPath = path.join(folder, item)
      try {
        if (excludes.some(regex => regex.test(item))) continue
        if (fullExcludes.some(regex => regex.test(newPath))) continue
        if (!fs.existsSync(newPath)) continue
        const stats = fs.lstatSync(newPath)
        if (stats.isSymbolicLink()) continue
        if (stats.isDirectory()) {
          parentRecord[item] = {}
          scan(newPath, parentRecord[item])
        } else parentRecord[item] = stats.size
      } catch (err) {
        console.error(`Error reading item ${newPath}:`)
        console.error(err)
      }
    }
  } catch (err) {
    console.error(`Error reading folder ${folder}:`)
    console.error(err)
  }
}

console.log('Scanning...')

scan(root, record)

if (fs.existsSync(statePath)) {
  const { root: oldRoot, record: oldRecord } = JSON.parse(fs.readFileSync(statePath))
  if (root === oldRoot) {
    console.log('Evaluating diff...')
    const currentPath = []
    const diff = []
    const computeDiff = (old, current) => {
      const oldKeys = new Set(Object.keys(old))
      const currentKeys = new Set(Object.keys(current))
      const onlyOldKeys = oldKeys.difference(currentKeys)
      const onlyCurrentKeys = currentKeys.difference(oldKeys)
      const sharedKeys = oldKeys.intersection(currentKeys)
      for (const key of onlyOldKeys) {
        currentPath.push(key)
        const value = old[key]
        if (typeof value === 'number') diff.push({ path: [...currentPath], mode: 'Removed' })
        else computeDiff(value, {})
        currentPath.pop()
      }
      for (const key of onlyCurrentKeys) {
        currentPath.push(key)
        const value = current[key]
        if (typeof value === 'number') diff.push({ path: [...currentPath], mode: 'New' })
        else computeDiff({}, value)
        currentPath.pop()
      }
      for (const key of sharedKeys) {
        currentPath.push(key)
        const oldValue = old[key]
        const currentValue = current[key]
        if (typeof oldValue === 'number' && typeof currentValue === 'number') {
          if (oldValue > currentValue) diff.push({ path: [...currentPath], mode: 'Shrunk' })
          else if (oldValue < currentValue) diff.push({ path: [...currentPath], mode: 'Grown' })
        } else computeDiff(oldValue, currentValue)
        currentPath.pop()
      }
    }
    computeDiff(oldRecord, record)

    let stringDiff = ''
    lastPath = []
    const diffCount = diff.length

    while (diff.length) {
      const { path: itemPath, mode } = diff.pop()
      let index
      for (index = 0; index < itemPath.length - 1; index++)
        if (index > lastPath.length || lastPath[index] !== itemPath[index]) break
      if (index !== itemPath.length - 1)
        for (let subIndex = index; subIndex < itemPath.length - 1; subIndex++)
          stringDiff += `\n${' '.repeat(subIndex * 2 + 1)} ${itemPath[subIndex]}: (${itemPath.slice(0, subIndex + 1).join('/')})`
      lastPath = itemPath.slice(0, itemPath.length - 1)
      stringDiff += `\n${' '.repeat(itemPath.length * 2 + 1)} ${itemPath[itemPath.length - 1]} : ${mode} (${path.join(...itemPath)})`
    }

    console.log(stringDiff)

    fs.writeFileSync(resultPath, stringDiff)

    console.log(`Results of ${diffCount} changes saved in ${resultPath}`)
  }
}

fs.writeFileSync(statePath, JSON.stringify({ root, record }))
