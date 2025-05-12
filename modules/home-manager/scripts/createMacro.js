const { exec } = require("node:child_process");
const path = require("node:path");
const fs = require("node:fs");
const readline = require("node:readline");

const homePath = "/persist/nixos/home-manager/home.nix";
const hyprlandPath = "/persist/nixos/modules/home-manager/hyprland.nix";
const scriptsPath = "/persist/nixos/modules/home-manager/scripts";

const rl = readline.createInterface({
	input: process.stdin,
	output: process.stdout,
});

const askQuestion = (question) =>
	new Promise((resolve) => rl.question(question, (answer) => resolve(answer)));

const name = await askQuestion("What should the name of the macro be?: ");
const hasTrigger =
	(
		await askQuestion("Does this macro need a key combo? (Y/n): ")
	).toLowerCase() !== "n";
const mods = hasTrigger ? await askQuestion("What mod keys?: ") : "";
const key = hasTrigger ? await askQuestion("What key?: ") : "";

if (
	name.length === 0 ||
	(hasTrigger && (mods.length === 0 || key.length === 0))
)
	throw new Error("Invalid input");
if (fs.readdirSync(scriptsPath).some((n) => n.split(".")[0] === name))
	throw new Error("That name is already used");

fs.writeFileSync(
	path.resolve(scriptsPath, `${name}.nix`),
	`{pkgs}:\npkgs.writeShellScriptBin "${name}" ''\n  bun "/persist/nixos/modules/home-manager/scripts/${name}.js"\n''`,
);
fs.writeFileSync(
	path.resolve(scriptsPath, `${name}.js`),
	'const { execSync, exec } = require("node:child_process");const path = require("node:path");\nconst fs = require("node:fs");\n\nconst statePath = `${process.argv[1].slice(0, process.argv[1].length - 2)}state`;',
);
fs.writeFileSync(
	homePath,
	fs
		.readFileSync(homePath, "utf8")
		.split("\n")
		.map((l) =>
			/# <MACRO INSERT>/.test(l)
				? `${l}\n    (import ../modules/home-manager/scripts/${name}.nix {inherit pkgs;})`
				: l,
		)
		.join("\n"),
);
if (hasTrigger)
	fs.writeFileSync(
		hyprlandPath,
		fs
			.readFileSync(hyprlandPath, "utf8")
			.split("\n")
			.map((l) =>
				/# <MACRO INSERT>/.test(l)
					? `${l}\n          "${mods},${key},exec,${name}"`
					: l,
			)
			.join("\n"),
	);

exec(`code ${path.resolve(scriptsPath, `${name}.js`)}`, { detached: true });
console.log("Macro created!");
console.log(
	`Run it with "bun /${path.resolve(scriptsPath, `${name}.js`)}" or just ${name} after a reload`,
);
process.exit(0);
