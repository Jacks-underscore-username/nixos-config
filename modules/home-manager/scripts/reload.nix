{pkgs}:
pkgs.writeShellScriptBin "reload" ''
  # A rebuild script that commits on a successful build, and then tries to push

  # where do you keep your *.nix files?
  directory=/persist/nixos # should contain hardware-configuration.nix

  if [ -z "$1" ]
    then
      echo "You need to pass in the name of the profile to switch to."
      exit 1
  fi

  # cd to your config dir
  {
    pushd $directory
  } > /dev/null

  git add -A

  set -e # needed to move this down because of the git status section

  # Autoformat your nix files
  ${pkgs.alejandra}/bin/alejandra . &>/dev/null \
    || ( ${pkgs.alejandra}/bin/alejandra . ; echo "Formatting failed!" && exit 1)

  # Early return if no changes were detected (thanks @singiamtel!)
  if git diff HEAD --quiet; then
      echo "No changes detected, exiting."
      {
          popd
      } > /dev/null
      exit 0
  fi

  # Apply the changes
  echo "Building..."
  if sudo nixos-rebuild switch --flake $directory/#$1; then

    # Reload hyprland manually
    hyprctl reload

    # Commit all changes with the current generation or the user supplied message
    if [ -z "$2" ]
      then
        git commit -m "Generation #$(readlink /nix/var/nix/profiles/system | cut -d- -f2)"
    else
      git commit -m "$2"
    fi

    echo "Reload complete!"

    echo "Pushing now..."

    if git push; then
        echo "Pushed!"
    else
        echo "Failed to push."
    fi

  else

  	sudo git restore --staged ./**/*.nix

    echo "Failed to reload..."
  fi

  # Back to where you were
  {
    popd
  } > /dev/null
''
