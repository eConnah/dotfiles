{inputs, ...}: {
  flake.nixosModules.turtle-disko = {
    imports = [inputs.disko.nixosModules.disko];
    disko.devices.disk = {
      hdd = {
        content = {
          partitions = {
            storage = {
              content = {
                extraArgs = ["-f"];
                subvolumes = {
                  "/data" = {
                    mountOptions = [
                      "subvol=data"
                      "compress=zstd:3"
                      "noatime"
                    ];
                    mountpoint = "/data";
                  };
                };
                type = "btrfs";
              };
              size = "100%";
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/ata-TOSHIBA_DT01ACA100_897K99ANS";
        type = "disk";
      };
      main = {
        content = {
          partitions = {
            esp = {
              content = {
                format = "vfat";
                mountOptions = ["umask=0077"];
                mountpoint = "/boot";
                type = "filesystem";
              };
              name = "ESP";
              priority = 1;
              size = "5G";
              type = "EF00";
            };
            root = {
              content = {
                extraArgs = ["-f"];
                subvolumes = {
                  "/@nix" = {
                    mountOptions = [
                      "subvol=@nix"
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };
                  "/@persistent" = {
                    mountOptions = [
                      "subvol=@persistent"
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/persistent";
                  };
                  "/@snapshots" = {
                    mountOptions = ["subvol=@snapshots"];
                    mountpoint = "/snapshots";
                  };
                  "/@void" = {
                    mountOptions = [
                      "subvol=@void"
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/";
                  };
                  "/@void-blank" = {
                    mountOptions = ["subvol=@void-blank"];
                  };
                };
                type = "btrfs";
                postMountHook = ''
                  mkdir -p /mnt/persistent/var/lib/nixos
                '';
              };
              name = "root";
              priority = 2;
              size = "100%";
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/ata-SanDisk_SDSSDH3_500G_21107B801252";
        type = "disk";
      };
    };
    fileSystems = {
      "/nix".neededForBoot = true;
      "/persistent".neededForBoot = true;
      "/var/lib/nixos" = {
        device = "/persistent/var/lib/nixos";
        fsType = "none";
        options = ["bind"];
        neededForBoot = true;
        depends = ["/persistent"];
      };
    };
  };
}
