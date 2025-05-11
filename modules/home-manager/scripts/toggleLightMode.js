const { execSync } = require("node:child_process");
const fs = require("node:fs");
const path = require("node:path");

const statePath = path.resolve(process.argv[1], "../toggleLightMode.state");

if (fs.existsSync(statePath))
	fs.writeFileSync(
		statePath,
		fs.readFileSync(statePath) === "dark" ? "light" : "dark",
	);
else fs.writeFileSync(statePath, "dark");

execSync("hyprctl dispatch exec hyprpaperManager");
