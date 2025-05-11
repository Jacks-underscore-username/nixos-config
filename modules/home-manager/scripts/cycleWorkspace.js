const { execSync } = require("node:child_process");

const focusedWorkspace = execSync(
	"hyprctl activeworkspace | grep \"workspace ID\" | awk '{print $3}' | head -n 1 | sed 's/.*\\([0-9]\\)$/\\1/'",
)
	.toString()
	.trim();
const focusedMonitor = execSync(
	"hyprctl activeworkspace | grep \"monitorID\" | awk '{print $2}'",
)
	.toString()
	.trim();
const monitorWorkspaces = execSync("hyprctl workspaces")
	.toString()
	.split("workspace ID ")
	.filter((x) => x.length)
	.filter((x) => x.includes(`monitorID: ${focusedMonitor}`))
	.map((x) => x.match(/^[0-9]+/)?.[0]);

const targetId =
	monitorWorkspaces[
		(monitorWorkspaces.indexOf(focusedWorkspace) +
			Number.parseInt(process.argv[2]) +
			monitorWorkspaces.length) %
			monitorWorkspaces.length
	];

if (targetId !== focusedWorkspace)
	execSync(`hyprctl dispatch workspace ${targetId}`);
