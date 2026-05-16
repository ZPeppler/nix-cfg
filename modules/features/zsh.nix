{ config, pkgs, self, inputs, ... }:
{
  flake.homeModules.zsh = { pkgs, lib, ... }: {
    programs.zsh = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myZSH;
    };
  };
  
  perSystem = { pkgs, libs, self', ... }: {
    packages.myZSH = inputs.wrapper-modules.wrappers.zsh.wrap {
      inherit pkgs;
      
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
          file = "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
          file = "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
      ];

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      initContent = ''
        # Custom zsh
        source "$HOME/.config/zsh/custom.zsh"

        #  Aliases
        source "$HOME/.config/zsh/aliases.zsh"

        # Custom functions
        source "$HOME/.config/zsh/functions.zsh"
      '';
    };
  };
}
