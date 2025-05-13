const fs = require("node:fs");
const path = require("node:path");
console.log(process.argv);
for (const file of ["biome.jsonc", "jsconfig.json"])
	fs.symlinkSync(path.join(__dirname, file), path.join("/persist/nixos", file));
