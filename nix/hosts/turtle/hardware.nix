{
  flake.nixosModules.turtle-hardware = {
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot = {
      extraModulePackages = [];
      initrd = {
        availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usb_storage"
          "sd_mod"
        ];
        kernelModules = [];
        supportedFilesystems = ["f2fs"];
        systemd.services.wipe-root = {
          after = ["dev-disk-by\\x2dpartlabel-disk\\x2dmain\\x2droot.device"];
          before = ["sysroot.mount"];
          description = "Reformat root filesystem";
          serviceConfig = {
            ExecStart = "${pkgs.f2fs-tools}/bin/mkfs.f2fs -f -l root /dev/disk/by-partlabel/disk-main-root";
            Type = "oneshot";
          };
          unitConfig.DefaultDependencies = "no";
          wantedBy = ["initrd.target"];
        };
      };
      kernelModules = [
        "kvm-intel"
      ];
    };
    environment.etc."machine-id".text = "913d87e12b95456b83a3427fbd512e9b\n";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
