const { execSync } = require("node:child_process");
const path = require("node:path");
const fs = require("node:fs");

const papersPath = path.resolve(
	process.argv[1],
	"../../../../assets/wallpapers",
);
const [lightPath, darkPath] = ["light", "dark"].map((i) =>
	path.resolve(papersPath, i),
);
const modePath =
	"/persist/nixos/modules/home-manager/scripts/toggleLightMode.state";

fs.writeFileSync("/home/jackc/.config/hypr/hyprpaper.conf", "");

const [lightPapers, darkPapers] = [lightPath, darkPath].map(
	(p) => new Set(fs.readdirSync(p)),
);
const lastPapers = new Set();

const isLightMode = () =>
	fs.existsSync(modePath) && fs.readFileSync(modePath) === "light";

const randomizePapers = async () => {
	while (true)
		try {
			const monitors = JSON.parse(
				execSync("hyprctl monitors -j").toString(),
			).map((e) => e.name);
			const currentPapers = new Set();
			for (const name of monitors) {
				const validPapers = (isLightMode() ? lightPapers : darkPapers)
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
			break;
		} catch (e) {
			while (true) {
				try {
					if (execSync("hyprctl hyprpaper").toString() === "invalid command\n")
						break;
				} catch (e) {}
				execSync("hyprctl dispatch exec hyprpaper");
				await new Promise((r) => setInterval(r, 100));
			}
		}
};

randomizePapers();

let lastMonitors;
if (
	execSync("ps -ef | grep hyprpaperManager.js").toString().split("\n")
		.length === 4
)
	setInterval(() => {
		try {
			const monitors = JSON.parse(execSync("hyprctl monitors -j").toString())
				.map((e) => e.name)
				.sort()
				.join(", ");
			if (monitors !== lastMonitors) {
				randomizePapers();
				lastMonitors = monitors;
			}
		} catch (e) {}
	}, 1000);
