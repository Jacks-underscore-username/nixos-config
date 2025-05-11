const { execSync } = require("node:child_process");
const path = require("node:path");
const fs = require("node:fs");

const assetsPath = path.resolve(process.argv[1], "../../../../assets");
const papersPath = path.resolve(assetsPath, "wallpapers");
const blankPath = path.resolve(assetsPath, "1x1_#000000FF.png");
fs.writeFileSync(
	"/home/jackc/.config/hypr/hyprpaper.conf",
	`preload = ${blankPath}\nwallpaper = ,${blankPath}`,
);

const allPapers = new Set(fs.readdirSync(papersPath));
const lastPapers = new Set();

const randomizePapers = () => {
	const monitors = JSON.parse(execSync("hyprctl monitors -j").toString()).map(
		(e) => e.name,
	);
	const currentPapers = new Set();
	for (const name of monitors) {
		const validPapers = allPapers
			.difference(lastPapers)
			.difference(currentPapers);
		const paper =
			Array.from(validPapers)[Math.floor(Math.random() * validPapers.size)];
		currentPapers.add(paper);
		const paperPath = path.resolve(papersPath, paper);
		execSync(`hyprctl hyprpaper reload "${name},${paperPath}"`);
	}
	lastPapers.clear();
	for (const paper of currentPapers) lastPapers.add(paper);
};

randomizePapers();

const timeArg = process.argv[2];
console.log(timeArg);
const timeUnit = timeArg[timeArg.length - 1];
const timeNumber = Number.parseInt(timeArg.slice(0, timeArg.length - 1));
const time =
	timeUnit === "h"
		? timeNumber * 1000 * 60 * 60
		: timeUnit === "m"
			? timeNumber * 1000 * 60
			: timeNumber * 1000;
console.log(time);
setInterval(randomizePapers, time);
