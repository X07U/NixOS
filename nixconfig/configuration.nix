{ config, pkgs, lib, inputs, ... }: {
# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ CORE ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 
  imports = [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./disko.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; 
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
# these 3 are the easiest way to setup qt themes globally, the config options are horrible. 
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
# not sure about qt6, but some packages claim they support both qt5 and qt6, it's such a mess
    # QT_QPA_PLATFORMTHEME_qt6 = "qt6ct";
  };
  xdg.mime.defaultApplications = {
    "inode/directory" = "Thunar.desktop";
  };
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  services.passSecretService.enable = true;
  system.stateVersion = "24.05"; 
  powerManagement.enable = true;
  services.thermald.enable = true;
  nix.optimise.automatic = true;
  security.polkit.enable = true;
  services.thinkfan.enable = true;

# ✨ SYSTEMD ✨


# ✨ GRUB ✨

  boot.loader = {
efi.efiSysMountPoint = "/boot";
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    timeout = 1;
    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ PROGRAMS ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  programs = {
    hyprland.enable = true;
    firefox.enable = true;
    zsh.enable = true;
    file-roller.enable = true;
    xfconf.enable = true;
    fzf.fuzzyCompletion = true;
  };

  environment.systemPackages = with pkgs; [
    hyprpicker
    wl-clipboard
    brightnessctl
    hyprshot
    nil
    vscode-langservers-extracted
    greetd.tuigreet
    pavucontrol
    mpd
    libsForQt5.qt5.qtwayland
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qt6ct
    (catppuccin-kvantum.override {
      accent = "mauve";
      variant = "mocha";
    })
    inkscape
    onlyoffice-desktopeditors
#this is only needed to fix invisible Xcursor in some Xwayland apps via "xsetroot -cursor_name left_ptr" - see hyprland config
    xorg.xsetroot
    ffmpeg
    fzf
    xdg-utils
    libsecret
    # jellyfin
    # jellyfin-web
    # jellyfin-ffmpeg
fd
  ];

  # services.jellyfin = {
  #   enable = true;
  #   openFirewall = true;
  # };

  # services.plex = {
  #   enable = true;
  #   openFirewall = true;
  #   user = "xozu";
  # };
  
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ NETWORK ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  networking = {
    hostName = "nixos"; 
    networkmanager.enable = true;
  };
  programs.nm-applet.enable = true;

# ✨ BLUETOOTH ✨

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ LOCALES ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  time.timeZone = "Europe/Bratislava";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sk_SK.UTF-8";
    LC_IDENTIFICATION = "sk_SK.UTF-8";
    LC_MEASUREMENT = "sk_SK.UTF-8";
    LC_MONETARY = "sk_SK.UTF-8";
    LC_NAME = "sk_SK.UTF-8";
    LC_NUMERIC = "sk_SK.UTF-8";
    LC_PAPER = "sk_SK.UTF-8";
    LC_TELEPHONE = "sk_SK.UTF-8";
    LC_TIME = "sk_SK.UTF-8";
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ SERVICES ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  services = {
    flatpak.enable = true;
    gvfs.enable = true;
    tlp.enable = true;
    printing.enable = true;
    tumbler.enable = true;
  };

# ✨ GREETD ✨

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --asterisks-char '•' --greeting 'System Operational ... Authentication in Progress' --user-menu --remember --theme 'border=magenta;text=cyan;prompt=gree;time=magenta;action=magenta;container=black;input=magenta' --cmd Hyprland";
        user = "greeter";
      };
    };
  };
# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ SOUND ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ USER ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

users.mutableUsers = false;
  users.users.xozu = {
    isNormalUser = true;
    hashedPasswordFile = "/persist/xozupass";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  environment.pathsToLink = [ "/share/zsh" ];

 # ✨ HOME MANAGER ✨ 

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "xozu" = import ./home.nix;
    };
  };

 # ✨ QT ✨ 

# QT is a bitch. The only way I made it work, is via Home Manager and config variables (see at the top). The wiki leads to a shitfest forum post.

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ STYLIX ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛   
   
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://i.postimg.cc/SKJtdrYT/wallpaper.png";
      sha256 = "sha256-E6W5wRTkX+g737+l3BqOkb68phtKCcl3HBeIZ8ij6tg=";
    };
    base16Scheme = {
      base00 = "14131d";
      base01 = "343051";
      base02 = "3b3854";
      base03 = "343051";
      base04 = "7b7bbb";
      base05 = "b8b8ff";
      base06 = "b8b8ff";
      base07 = "0b091d";
      base08 = "ff8888";
      base09 = "ffa588";
      base0A = "fffdd0";
      base0B = "88ff88";
      base0C = "88ffff";
      base0D = "beddff";
      base0E = "e7c5ff";
      base0F = "b8b8ff";
    };
    autoEnable = true;
    cursor = {
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 16;
    };
    targets = {
      grub.enable = false;
    };
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ THUNAR ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  #to open files with Helix (or any other terminal app) do "open with -> set default application -> command 'kitty -e hx %F'"
  #to fix openTerminal, do edit -> configure custom actions -> settings -> command 'kitty'
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };

services.mpd = {
		enable = true;
    user = "xozu";
    musicDirectory = "/home/xozu/Music";
    extraConfig = ''
  audio_output {
    type "alsa"
    name "My ALSA"
    mixer_type		"hardware"
    mixer_device	"default"
    mixer_control	"PCM"
  }
'';
	};

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["xozu"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +10); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

fileSystems."/persist".neededForBoot = true;
zramSwap.enable = true;
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
   users.xozu = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".nixops"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        ".local/share/direnv"
      ];
      files = [
        ".screenrc"
      ];
    };
  };

}
