const { execSync } = require("node:child_process");
const path = require("node:path");

const papersPath = path.resolve(
	process.argv[1],
	"../../../../assets/wallpapers",
);

console.log(papersPath);
