{ self, inputs, ... }: {
  flake.nixosModules.nixos-srv-configuration = { config, lib, pkgs, ... }: {
    imports =
      [ # Include the results of the hardware scan.
        self.nixosModules.nixos-srv-hardware
        self.nixosModules.starship
        inputs.nix-ld.nixosModules.nix-ld
      ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos-srv"; # Define your hostname.

    networking.networkmanager.enable = true;

    networking.firewall.allowedTCPPorts = [ 22 ];

    time.timeZone = "America/New_York";
    services.openssh.enable = true;

    security.sudo = {
      wheelNeedsPassword = false;
      extraConfig = ''
        Defaults pwfeedback
      '';
    };

    users.users.zpeppler = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        neovim
        nodejs
        uv
        cargo
        fzf
        eza
        starship
        yazi
        lazygit
        wl-clipboard
        tree-sitter
        sshfs
      ];
    };

    home-manager.users.zpeppler = self.homeModules.zpepplerModule;

    environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      git
      curl
      zip
      unzip
      coreutils
      uv
      tmux
      sesh
      television
      lua5_1
      wl-clipboard
      luarocks
      tree-sitter
      fd
      fzf
      ripgrep
      nodejs
    ];
    programs.nix-ld.dev.enable = true;
    system.stateVersion = "26.05"; # Did you read the comment?

  };

}
