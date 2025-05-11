const path = require("node:path");
const fs = require("node:fs");
const { Vibrant: vibrant } = require("node-vibrant/node");

const colors = {};

const papersPath = path.resolve(process.argv[1], "../wallpapers");
const [lightPath, darkPath] = ["light", "dark"].map((i) =>
	path.resolve(papersPath, i),
);

const resultsPath = path.resolve(process.argv[1], "../wallpaperColors.json");

for (const subPath of [lightPath, darkPath])
	for (const paper of fs.readdirSync(subPath)) {
		const palette = await vibrant
			.from(path.resolve(subPath, paper))
			.getPalette();
		colors[`${subPath.endsWith("dark") ? "dark" : "light"}_${paper}`] =
			Object.fromEntries(
				Object.entries(palette).map(([k, v]) => [
					k,
					{ population: v.population, hex: v.hex },
				]),
			);
		console.log(`Got colors for ${paper}`);
	}

fs.writeFileSync(resultsPath, JSON.stringify(colors, undefined, 2));
