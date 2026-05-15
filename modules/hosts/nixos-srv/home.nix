{ config, self, inputs, ... }: 
let
  dotfile="${config.home.homeDirectory}/Projects/nix-cfg/modules/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    sesh = "sesh";
  };
{
  
  flake.homeConfigurations.zpeppler = inputs.home-manager.lib.homeManagerConfiguration 
  {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.zpepplerModule
      {
        home = {
          username = "zpeppler";
          homeDirectory = "/home/zpeppler";
          sessionVariables = {
            EDITOR = "nvim";
            VISUAL = "nvim";
          };
        };
      }
    ];
  };

  flake.homeModules.zpepplerModule = { pkgs, ... }: {
    
    home.stateVersion = "26.05";
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
      bash = { 
        enable = true;
        shellAliases = {
          ll = "ls -l";
          lla = "ls -la";
          nrs = "sudo nixos-rebuild switch --flake $HOME/Projects/nix-cfg#$(hostname -f)";
        };
        initExtra = ''
        eval "$(starship init bash)"         
        export STARSHIP_CONFIG="/etc/starship-root.toml"
        '';
      };

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

    xdg.configFile = builtins.mapAttrs( name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    }) configs;
  };
}

