{ self, inputs, ... }:

{
  flake.nixosModules.nixos-srv-disko = {

    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persistent".neededForBoot = true;

    disko.devices.nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=25%"
          "mode=775"
        ];
      };
    };

    disko.devices.disk.main = {
      device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
      type = "disk";

      content = { 
        type = "gpt"; 

        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };

          esp = {
            name = "ESP";
            size = "1G";
            type = "EF00";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          swap = {
            size = "4G";

            content = {
              type = "swap";
              resumeDevice = true;

            };
          };

          root = {
            name = "root";
            size = "100%";

            content = {
              type = "btrfs";
              extraArgs = ["-f"];

              subvolumes = {
                "/persistent" = {
                  mountOptions = ["subvol=persist" "noatime"];
                  mountpoint = "/persistent";
                };

                "/nix" = {
                  mountOptions = ["subvol=nix" "noatime"];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
  };
}
