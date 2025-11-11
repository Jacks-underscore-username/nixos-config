{pkgs, ...}: let
  user = "jackc";
in {
  systemd.services.codeBackup = {
    enable = true;
    description = "Backup the code folder";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target" "shutdown.target"];
    serviceConfig = {
      Type = "oneshot";
      Conflicts = ["shutdown.target"];
      Before = ["shutdown.target"];

      User = user;
      Environment = ["HOME=/home/${user}"];
    };
    script = ''
      echo "--- Code Backup Service Diagnostic Output ---"
      echo "Running as user: $(whoami)"
      echo "HOME environment variable: $HOME"
      echo "Contents of HOME: $(ls -la $HOME)"
      echo "Contents of ~/.ssh: $(ls -la $HOME/.ssh)"
      echo "Permissions of ~/.ssh/known_hosts: $(stat -c "%a %n" $HOME/.ssh/known_hosts 2>/dev/null || echo 'known_hosts not found')"
      echo "SSH_KNOWN_HOSTS_FILE: $SSH_KNOWN_HOSTS_FILE"
      echo "PATH: $PATH"
      echo "Trying to connect to 192.168.4.62..."

      ${pkgs.openssh}/bin/ssh \
        -vvv \
        -i $HOME/.ssh/id_ed25519 \
        -o UserKnownHostsFile=$HOME/.ssh/known_hosts \
        -o StrictHostKeyChecking=yes \
        192.168.4.62 \
        'echo "Hello from the other server!" | wall'

      SSH_EXIT_CODE=$?
      if [ $SSH_EXIT_CODE -ne 0 ]; then
        echo "SSH command failed with exit code: $SSH_EXIT_CODE"
        exit $SSH_EXIT_CODE
      fi
      echo "SSH command succeeded."
      echo "--- End Diagnostic Output ---"
    '';
  };
}
