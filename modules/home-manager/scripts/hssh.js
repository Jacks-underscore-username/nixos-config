const { exec, spawn, execSync, spawnSync } = require('node:child_process')
const path = require('node:path')
const fs = require('node:fs')
const readline = require('node:readline')

const statePath = path.resolve(process.argv[1] ?? '', '../hssh.state')
const modulesPath = path.resolve(statePath, '../../../../node_modules')
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

  /**
   * @param {string} question
   * @param {string[]} options
   * @returns {Promise<string>}
   */
  const askStrictQuestion = (question, options) =>
    new Promise(async resolve => {
      while (true) {
        const answer = (await askQuestion(`${question} (${options.join(', ')}): `)).trim()
        if (options.includes(answer)) return resolve(answer)
        console.log(`Unknown answer "${answer}", try again`)
      }
    })

  /** @type {Object<string, { address: string, username: string }>}>} */
  const knownPeers = {
    relay: { address: '', username: '' },
    server: { address: '0537552f0c08316634f2450ed0241c7c06a8d4bdcc2fbc6324b4efeae27980a1', username: 'jackc' },
    nix: { address: 'bd9af6d0090bd3bfd7dadf3022aa5a373d84ebd550152d51e7afc56ce24fb0a0', username: 'jackc' },
    phone: { address: '', username: '' }
  }

  const asServer = await askBooleanQuestion('Are you the server?')

  if (asServer) {
    if (!fs.existsSync(statePath)) {
      const seed = await new Promise(resolve => {
        exec(`node "${path.join(modulesPath, 'hyper-cmd-utils', 'keygen.js')}" --gen_seed`, (_1, stdout, _2) => {
          resolve(stdout)
        })
      })
      fs.writeFileSync(statePath, seed.slice(6).split('\n')[0], 'utf8')
    }
    const child = spawn(
      `node "${path.join(modulesPath, 'hypertele', 'server.js')}" --seed ${fs.readFileSync(statePath, 'utf8')} -l 22`,
      { shell: true }
    )
    const address = await new Promise(resolve => {
      child.stdout.on('data', data => {
        resolve(String(data).slice(11))
      })
    })
    console.log(`Hyperssh server listening on ${address}`)
  } else {
    const peer = knownPeers[await askStrictQuestion('Address?', Object.keys(knownPeers))]
    if (peer === undefined) throw new Error('Uh oh')
    const { address, username } = peer
    spawn(`node "${path.join(modulesPath, 'hyperssh', 'client.js')}" -s ${address} -u ${username} -t`, {
      stdio: 'inherit',
      shell: true
    })
  }

  // process.exit(0)
})()
