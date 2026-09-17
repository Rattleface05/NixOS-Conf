# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
  ];

  # DONT Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;

  # gwub
  boot.loader = {

    grub = {
      enable = true;
      configurationLimit = 7;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      extraEntries = ''
        menuentry "UEFI Firmware Settings" {
          fwsetup
        }
      '';
    };

    efi.canTouchEfiVariables = true;

  };
  # Use CachyOS kernel.
  #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-x86_64-v3;
  # For lto extra power bitch
  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;

  # Vanilla kernek
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  networking.hostName = "cratita"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # No firewall,  i like it raw
  networking.firewall.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  #services.xserver = {
  #  enable = false;
  #  excludePackages = with pkgs; [ xterm ];
  #};

  # Drivers
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable flatpak
  services.flatpak.enable = true;

  # Enable nix-ld to unfuck generic executables
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      #sqlite
      webkitgtk_4_1
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd

      # My own additions
      libXcomposite
      libXtst
      libXrandr
      libXext
      libX11
      libXfixes
      libGL
      libva
      pipewire
      libxcb
      libXdamage
      libxshmfence
      libXxf86vm
      libelf

      # Required
      glib
      gtk2

      # Inspired by steam
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
      networkmanager
      vulkan-loader
      libgbm
      libdrm
      libxcrypt
      coreutils
      pciutils
      zenity
      # glibc_multi.bin # Seems to cause issue in ARM

      # # Without these it silently fails
      libXinerama
      libXcursor
      libXrender
      libXScrnSaver
      libXi
      libSM
      libICE
      nspr
      nss
      cups
      libcap
      SDL2
      libusb1
      dbus-glib
      ffmpeg
      # Only libraries are needed from those two
      libudev0-shim

      # needed to run unity
      gtk3
      icu
      libnotify
      gsettings-desktop-schemas
      # https://github.com/NixOS/nixpkgs/issues/72282
      # https://github.com/NixOS/nixpkgs/blob/2e87260fafdd3d18aa1719246fd704b35e55b0f2/pkgs/applications/misc/joplin-desktop/default.nix#L16
      # log in /home/leo/.config/unity3d/Editor.log
      # it will segfault when opening files if you don’t do:
      # export XDG_DATA_DIRS=/nix/store/0nfsywbk0qml4faa7sk3sdfmbd85b7ra-gsettings-desktop-schemas-43.0/share/gsettings-schemas/gsettings-desktop-schemas-43.0:/nix/store/rkscn1raa3x850zq7jp9q3j5ghcf6zi2-gtk+3-3.24.35/share/gsettings-schemas/gtk+3-3.24.35/:$XDG_DATA_DIRS
      # other issue: (Unity:377230): GLib-GIO-CRITICAL **: 21:09:04.706: g_dbus_proxy_call_sync_internal: assertion 'G_IS_DBUS_PROXY (proxy)' failed

      # Verified games requirements
      libXt
      libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew_1_10
      libidn
      tbb

      # Other things from runtime
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_ttf
      SDL2_mixer
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      libXft
      libvdpau
      # ...
      # Some more libraries that I needed to run programs
      pango
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      dbus
      alsa-lib
      expat
      # for blender
      libxkbcommon

      libxcrypt-legacy # For natron
      libGLU # For natron

      # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
      fuse
      e2fsprogs

      # darktable nightly AppImage https://github.com/darktable-org/darktable/releases
      gmp

      # RapidRaw
      harfbuzz
      libgpg-error
      # https://github.com/xournalpp/xournalpp/releases/download/v1.2.4/xournalpp-1.2.4-x86_64.AppImage
      fribidi
      librsvg
      # https://github.com/nix-community/nix-ld/issues/95#issuecomment-3041993870
      (runCommand "librsvg" { } ''
        mkdir -p $out/lib/gdk-pixbuf-2.0/2.10.0/loaders
        ln -s "${librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader_svg.so" "$out/lib/libpixbufloader-svg.so"
      '')

      # pdfmastereditor
      sane-backends
      pkcs11helper

      # Qt6 requires this (e.g. used in zxlive)
      libpulseaudio
      krb5
      libxcb-cursor
      xcbutilwm
      xcbutil
      xcbutilimage
      xcbutilkeysyms
      xcbutilrenderutil
    ];
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.plasma-login-manager.enable = true;
  services.displayManager.plasma-login-manager.settings = {
    Autologin = {
      Session = "plasma.desktop";
      User = "dumi";
    };
  };
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    kwin-x11
    kwallet
    kwalletmanager
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # ClamAV freshclam
  services.clamav.updater.enable = true;

  # QBitTorrent
  #services.qbittorrent = {
  #  enable = true;
  #  package = pkgs.qbittorrent-enhanced;
  #};

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # Use the WirePlumber session manager
    #wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."dumi" = {
    isNormalUser = true;
    description = "dumi";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Install firefox.
  programs.firefox = {
    enable = true;
    preferencesStatus = "user";
  };

  # Install steam.
  programs.steam.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;

  # Gmamemode
  programs.gamemode.enable = true;

  ## Lutris
  #programs.lutris.enable = true;
  #programs.lutris.extraPackages = with pkgs; [
  #  mangohud
  #  winetricks
  #  gamemode
  #  umu-launcher
  #];

  # GPU Screen Recoder
  programs.gpu-screen-recorder.enable = true;
  programs.gpu-screen-recorder.ui.enable = true;

  # Appimages
  programs.appimage.binfmt = true;
  programs.appimage.enable = true;

  # Virt Manager
  programs.virt-manager.enable = true;

  # Enable Libvirtd
  virtualisation.libvirtd.enable = true;

  # LazyVim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Optimize store
  nix.settings.auto-optimise-store = true;

  # Max 2 jobs
  nix.settings.max-jobs = 2;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    discord
    croc
    openssh
    alacritty
    ghostty
    git
    github-cli
    lazygit
    rustc
    cargo
    vscode
    kdePackages.kate
    kdePackages.filelight
    gcc
    fastfetch
    cowsay
    fortune
    inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
    ripgrep
    lua-language-server
    nodejs
    tree
    fzf
    bash-completion
    nix-bash-completions
    python3
    zip
    unzip
    haskell-language-server
    ghc
    statix
    wl-clipboard
    fd
    imagemagick
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })
    imgbrd-grabber
    audacity
    microcode-amd
    bottles
    qbittorrent-enhanced
    btop
    htop
    btrfs-progs
    btrfs-assistant
    clamav
    cmatrix
    gdu
    gimp
    godot
    protonplus
    shadps4-qtlauncher
    r2modman
    prismlauncher
    pipx
    ani-cli
    deadlock-mod-manager
    mangohud
    lutris
    pipes-rs
    rar
    stremio-linux-shell
    speedtest-rs
    wtf
    wtfis
    onlyoffice-desktopeditors
    gpu-screen-recorder-ui

    #AppImage bullshit
    (pkgs.callPackage ./antra.nix { })
  ];

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "26.05"; # Did you read the comment?

}
