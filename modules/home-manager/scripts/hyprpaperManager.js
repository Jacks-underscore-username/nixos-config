const { execSync } = require("node:child_process");
const path = require("node:path");

const papersPath = path.resolve(
	process.argv[1],
	"../../../../assets/wallpapers",
);

const loadedPapers = new Set();

const randomizePapers = () => {
	const monitors = execSync("hyprctl monitors -j");
	console.log(monitors);
};

// randomizePapers();

console.log(execSync("hyprctl monitors -j"));

// console.log(execSync("hyprctl workspaces"));
