const { execSync, exec } = require("node:child_process");const path = require("node:path");
const fs = require("node:fs");

const statePath = `${process.argv[1].slice(0, process.argv[1].length - 2)}state`;