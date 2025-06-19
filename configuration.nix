# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "esarverthinkpad"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.fira-code
  ];

  # Add the ability to run not-packaged programs, from nix.dev/permalink/stub-ld
  programs = {
    neovim = {
        enable = true;
        defaultEditor = true;
    };
    nix-ld = {
        enable = true;
        libraries = with pkgs; [
            openssl
      ];
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services = {
        fwupd.enable = true;
        pipewire = {
              enable = true;
              alsa.enable = true;
              alsa.support32Bit = true;
              pulse.enable = true;
              # If you want to use JACK applications, uncomment this
              #jack.enable = true;

              # use the example session manager (no others are packaged yet so this is enabled by default,
              # no need to redefine it in your config for now)
              #media-session.enable = true;
        };
        # Enable CUPS to print documents.
        printing.enable = true;
        desktopManager.cosmic.enable = true;
        displayManager.cosmic-greeter.enable = true;
        xserver = {
            # Enable the X11 windowing system.
            enable = true;
            # Enable the GNOME Desktop Environment.
            displayManager.gdm.enable = true;
            desktopManager.gnome.enable = true;
            # Configure keymap in X11
            xkb = {
                layout = "us";
                variant = "";
            };
        };
        udev.extraRules = ''
        # Copy this file to /etc/udev/rules.d/
        # If rules fail to reload automatically, you can refresh udev rules
        # with the command "udevadm control --reload"

        # This rules are based on the udev rules from the OpenOCD project, with unsupported probes removed.
        # See http://openocd.org/ for more details.
        #
        # This file is available under the GNU General Public License v2.0

        ACTION!="add|change", GOTO="probe_rs_rules_end"

        SUBSYSTEM=="gpio", MODE="0660", GROUP="plugdev", TAG+="uaccess"

        SUBSYSTEM!="usb|tty|hidraw", GOTO="probe_rs_rules_end"

        # Please keep this list sorted by VID:PID

        # STMicroelectronics ST-LINK V1
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", MODE="660", GROUP="plugdev", TAG+="uaccess"

        # STMicroelectronics ST-LINK/V2
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="660", GROUP="plugdev", TAG+="uaccess"

        # STMicroelectronics ST-LINK/V2.1
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", MODE="660", GROUP="plugdev", TAG+="uaccess"

        # STMicroelectronics STLINK-V3
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374d", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374e", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3753", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3754", MODE="660", GROUP="plugdev", TAG+="uaccess"

        # SEGGER J-Link
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0101", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0102", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0103", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0104", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0105", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0107", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0108", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1001", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1002", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1003", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1004", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1005", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1006", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1007", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1008", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1009", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="100a", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="100b", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="100c", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="100d", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="100e", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="100f", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1010", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1011", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1012", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1013", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1014", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1015", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1016", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1017", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1018", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1019", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="101a", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="101b", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="101c", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="101d", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="101e", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="101f", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1020", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1021", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1022", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1023", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1024", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1025", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1026", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1027", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1028", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1029", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="102a", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="102b", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="102c", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="102d", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="102e", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="102f", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1050", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1051", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1052", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1053", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1054", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1055", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1056", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1057", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1058", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1059", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="105a", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="105b", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="105c", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="105d", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="105e", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="105f", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1060", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1061", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1062", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1063", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1064", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1065", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1066", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1067", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1068", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1069", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="106a", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="106b", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="106c", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="106d", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="106e", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="1366", ATTRS{idProduct}=="106f", MODE="660", GROUP="plugdev", TAG+="uaccess"

        # FT232H
        ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", MODE="660", GROUP="plugdev", TAG+="uaccess"
        # FT2232x
        ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="660", GROUP="plugdev", TAG+="uaccess"
        # FT4232H
        ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6011", MODE="660", GROUP="plugdev", TAG+="uaccess"

        # FTDI-based Olimex devices
        ATTRS{idVendor}=="0x15ba", ATTRS{idProduct}=="0x0003", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="0x15ba", ATTRS{idProduct}=="0x0004", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="0x15ba", ATTRS{idProduct}=="0x002a", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="0x15ba", ATTRS{idProduct}=="0x002b", MODE="660", GROUP="plugdev", TAG+="uaccess"

        # Espressif USB JTAG/serial debug unit
        ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1001", MODE="660", GROUP="plugdev", TAG+="uaccess"
        # Espressif USB Bridge
        ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1002", MODE="660", GROUP="plugdev", TAG+="uaccess"

        ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE="660", GROUP="plugdev", TAG+="uaccess"
        ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000f", MODE="660", GROUP="plugdev", TAG+="uaccess"


        # CMSIS-DAP compatible adapters
        ATTRS{product}=="*CMSIS-DAP*", MODE="660", GROUP="plugdev", TAG+="uaccess"
        # WCH Link (CMSIS-DAP compatible adapter)
        ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="8011", MODE="660", GROUP="plugdev", TAG+="uaccess"

        LABEL="probe_rs_rules_end"
        '';
  };

  virtualisation = {
    containers.enable = true;
    podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Enable sound with pipewire.
#sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.groups.plugdev = {};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.esarver = {
    isNormalUser = true;
    description = "Edwin Sarver";
    extraGroups = [ "networkmanager" "wheel" "podman" "plugdev" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    gcc
    vivaldi
    podman-compose
  ];
  #environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
