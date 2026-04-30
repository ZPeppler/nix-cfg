{ self, inputs, ... }: {
  
  flake.homeConfigurations.zpeppler = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.zpepplerModule
      {
        home.username = "zpeppler";
        home.homeDirectory = "/home/zpeppler";
      }
    ];
  };

  flake.homeModules.zpepplerModule = { pkgs, ... }: {
    programs.bash.enable = true;
    programs.bash.shellAliases.ll = "ls -l";
    programs.bash.shellAliases.nrs = "sudo nixos-rebuild switch --flake $HOME/nix-cfg#nixosSrv";

    home.packages = with pkgs; [
      nodejs
      gcc
      uv
      cargo    
      # Terminal
      btop
      eza
      fastfetch
      ffmpeg
      fzf
      imagemagick
      jp
      matugen
      poppler
      ripgrep
      starship
      yazi
      zoxide
      lazygit
      neovim
    ];

    programs = {
      git = {
        enable = true;
        settings = {
          user = {
            name = "ZPeppler";
            email = "peppler.zachary@gmail.com";
          };
        };
      };
    };

    home.stateVersion = "26.05";
  };
}

