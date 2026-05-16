{ self, inputs, ... }: 

{
  flake.nixosModules.nixos-srv-configuration = { config, lib, pkgs, ... }: 
  {
    imports =
      [ # Include the results of the hardware scan.
        self.nixosModules.nixos-srv-hardware
        self.nixosModules.starship
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.default
        self.nixosModules.nixos-srv-disko
        self.nixosModules.preservation
        inputs.nix-ld.nixosModules.nix-ld
      ];
  
    # ---------------------------------------------
    # Nix Settings 
    # ---------------------------------------------

    nixpkgs = {
      config.allowUnfree = true;
    };

    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "root"
          "zpeppler"
        ];
      };
    };


    # ---------------------------------------------
    # Boot Settings 
    # ---------------------------------------------

    boot = { 
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      
      kernelPackages = pkgs.linuxPackages_latest;
      
      tmp = {
        useTmpfs = true;
        tmpfsSize = "4G";
        cleanOnBoot = true;
      };
    };

    # ---------------------------------------------
    # Network Settings 
    # ---------------------------------------------

    networking = {
      hostName = "nixos-srv";
      networkmanager.enable = true;
      firewall.allowedTCPPorts = [
        22
        9090
      ];
    };

    
    # ---------------------------------------------
    # Services 
    # ---------------------------------------------

    services = {
      openssh.enable = true;

      cockpit = {
        enable = true;
        port = 9090;
        plugins = with pkgs; [
          cockpit-podman
        ];
        settings = {
          WebService = {
            AllowUnencrypted = true;
          };
        };
      };
    };

    
    # ---------------------------------------------
    # Security
    # ---------------------------------------------

    security = {
      polkit.enable = true;
      rtkit.enable = true;

      sudo = {
        wheelNeedsPassword = false; 
        extraConfig = ''
          Defaults pwfeedback
        '';
      };
    };

    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    # ---------------------------------------------
    # Locale
    # ---------------------------------------------

    time.timeZone = "America/New_York";
    i18n = {
      defaultLocale = "en_US.UTF-8";
    };

    # ---------------------------------------------
    # Users
    # ---------------------------------------------

    users.mutableUsers = false;
    users.users.zpeppler= {
      isNormalUser = true;
      shell = pkgs.zsh;
      hashedPasswordFile = "/persistent/passwd";
      extraGroups = [ 
        "wheel" 
        "networkmanager"
        "podman"
        "storage"
      ];
    };

    home-manager.users.zpeppler = self.homeModules.zpepplerModule;

    # ---------------------------------------------
    # System Pacakges
    # ---------------------------------------------
    
    programs.nix-ld.dev.enable = true;
    environment.systemPackages = with pkgs; [
      vim
      wget
      git
      alacritty
      gcc
      gnumake
      libtool
      curl
      zip
      unzip
      coreutils
      clang
      cmake
      sshfs
      uv

      podman-compose

      cockpit
      cockpit-podman

      kubectl
      tmux
      sesh
      television
      wl-clipboard
      lua5_1
      luarocks
      tree-sitter
      unzip
      fd
      ripgrep
      fzf
      bat
      jq
      yq
      nodejs
    ];

    # ---------------------------------------------
    # Fonts
    # ---------------------------------------------

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only 
    ];

    systemd.services.systemd-machine-id-commit.enable = false;

    # ---------------------------------------------
    # System version
    # ---------------------------------------------
   
    system.stateVersion = "26.05"; 
  };

}
