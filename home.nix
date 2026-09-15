{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.lazyvim.homeManagerModules.default ];

  home = {
    stateVersion = "26.05";
    username = "dumi";
    homeDirectory = "/home/dumi";
  };

  programs.lazyvim = {
    enable = true;

    extras = {
      lang.nix.enable = true;
      lang.python = {
        enable = true;
        installDependencies = true; # Install ruff
        installRuntimeDependencies = false; # Install python3
      };

      lang.rust = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = false;
      };

      lang.cmake.enable = true;
      lang.docker = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = false;
      };

      coding.yanky.enable = true;

      linting.eslint.enable = true;

      lsp.neoconf.enable = true;

      ui.smear-cursor.enable = true;
    };

    # Additional packages (optional)
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      lua
      nix
    ];
  };

}
