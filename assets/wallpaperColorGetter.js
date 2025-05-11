const path = require("node:path");
const fs = require("node:fs");
const { Vibrant: vibrant } = require("node-vibrant/node");

const colors = {};

const papersPath = path.resolve(process.argv[1], "../wallpapers");

const resultsPath = path.resolve(process.argv[1], "../wallpaperColors.json");

for (const paper of fs.readdirSync(papersPath)) {
	const palette = await vibrant
		.from(path.resolve(papersPath, paper))
		.getPalette();
	colors[paper] = Object.fromEntries(
		Object.entries(palette).map(([k, v]) => [
			k,
			{ population: v.population, hex: v.hex },
		]),
	);
	console.log(`Got colors for ${paper}`);
}

fs.writeFileSync(resultsPath, JSON.stringify(colors, undefined, 2));
