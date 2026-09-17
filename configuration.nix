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
