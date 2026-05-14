{ inputs, ...}:
{
  flake.modules.nixos.fonts = { pkgs, ...}: {
    fonts.packages = with pkgs; [
      inter
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emogi
    ];

    fonts.fontconfig.defaultFonts = {
      monospace = ["JetBrainMono Nerd Font"];
      sanSerif = ["Noto Sans"];
      serf = ["Noto Serif"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
