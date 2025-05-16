const { execSync } = require('node:child_process')
const path = require('node:path')

execSync(`nix-shell ${path.join('/persist/nixos/shells', `${process.argv[2]}.nix`)}`)
