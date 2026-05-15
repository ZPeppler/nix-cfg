{ self, inputs, ... }:

{
  flake.nixosModules.preservation = {

    preservation = {
      enable = true;
      preserveAt."/persistent" = {
        users.zpeppler = {
         directories = [
           "Projects"
           ".ssh"
           ".local/state/nvim"
           ".local/share/nvim"
           ".tmux/plugins"
           ".venv"
         ];
        };

        files = [
          { 
            file = "/etc/machine-id"; 
            inInitrd = true; 
          }
        ];

        directories = [
          "/etc/nixos"
          "/var/lib/systemd/timers"
          "/var/lib/nixos"
          "/var/log"
          "/etc/NetworkManager/system-connections"
          "/etc/ssh"
        ];
      };
    };
  };
}
