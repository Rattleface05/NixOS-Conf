{ inputs, pkgs, ... }:
{
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

}
