const { exec } = require('node:child_process')
const path = require('node:path')
const fs = require('node:fs')
const readline = require('node:readline')

const homePath = '/persist/nixos/home-manager/home.nix'
const hyprlandPath = '/persist/nixos/modules/home-manager/hyprland.nix'
const scriptsPath = '/persist/nixos/modules/home-manager/scripts'
;(async () => {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  })

  /**
   * @param {string} question
   * @returns {Promise<string>}
   */
  const askQuestion = question => new Promise(resolve => rl.question(question, answer => resolve(answer)))

  /**
   * @param {string} question
   * @param {boolean} [defaultAnswer]
   * @returns {Promise<boolean>}
   */
  const askBooleanQuestion = (question, defaultAnswer) =>
    new Promise(async resolve => {
      const yeses = ['y', '1', 'yes', 't', 'true']
      const nos = ['n', '0', 'no', 'f', 'false']
      while (true) {
        const answer = (
          await askQuestion(
            `${question} (${defaultAnswer === true ? 'Y' : 'y'}/${defaultAnswer === false ? 'N' : 'n'}): `
          )
        ).trim()
        if (yeses.includes(answer.toLowerCase())) return resolve(true)
        if (nos.includes(answer.toLowerCase())) return resolve(false)
        if (!answer.length && defaultAnswer !== undefined) return resolve(defaultAnswer)
        console.log(`Unknown answer "${answer}", try again`)
      }
    })

  const macroOrAlias = process.argv.includes('--alias') ? 'alias' : 'macro'

  const name = await askQuestion(`What should the name of the ${macroOrAlias} be?: `)
  const hasTrigger = await askBooleanQuestion(`Does this ${macroOrAlias} need a key combo?`, false)
  const mods = hasTrigger ? await askQuestion('What mod keys?: ') : ''
  const key = hasTrigger ? await askQuestion('What key?: ') : ''
  const isJs = await askBooleanQuestion(`Is this ${macroOrAlias} written in JS?`, false)

  if (name.length === 0 || (hasTrigger && (mods.length === 0 || key.length === 0))) throw new Error('Invalid input')
  if (fs.readdirSync(scriptsPath).some(n => n.split('.')[0] === name)) throw new Error('That name is already used')

  fs.writeFileSync(
    path.resolve(scriptsPath, `${name}.nix`),
    isJs
      ? `{pkgs}:\npkgs.writeShellScriptBin "${name}" ''\n  bun "/persist/nixos/modules/home-manager/scripts/${name}.js" "$@"\n''`
      : `{pkgs}:\npkgs.writeShellScriptBin "${name}" ''\n  echo "Hello World!"\n''`
  )
  if (isJs)
    fs.writeFileSync(
      path.resolve(scriptsPath, `${name}.js`),
      'const { execSync, exec } = require("node:child_process");const path = require("node:path");\nconst fs = require("node:fs");\n\nconst statePath = `${process.argv[1].slice(0, process.argv[1].length - 2)}state`;'
    )

  fs.writeFileSync(
    homePath,
    fs
      .readFileSync(homePath, 'utf8')
      .split('\n')
      .map(l =>
        /# <MACRO INSERT>/.test(l)
          ? `${l}\n    (import ../modules/home-manager/scripts/${name}.nix {inherit pkgs;})`
          : l
      )
      .join('\n')
  )
  if (hasTrigger)
    fs.writeFileSync(
      hyprlandPath,
      fs
        .readFileSync(hyprlandPath, 'utf8')
        .split('\n')
        .map(l => (/# <MACRO INSERT>/.test(l) ? `${l}\n          "${mods},${key},exec,${name}"` : l))
        .join('\n')
    )

  // @ts-expect-error
  exec(`code ${path.resolve(scriptsPath, `${name}.${isJs ? 'js' : 'nix'}`)}`, { detached: true })
  console.log(`${macroOrAlias[0]?.toUpperCase()}${macroOrAlias.slice(1)} created!`)
  console.log(
    isJs
      ? `Run it with "bun /${path.resolve(scriptsPath, `${name}.js`)}" or just "${name}" after a reload`
      : `Run it with "${name}" after a reload`
  )
  process.exit(0)
})()
