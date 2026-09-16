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
      lang = {
        nix.enable = true;
        python = {
          enable = true;
          installDependencies = true; # Install ruff
          installRuntimeDependencies = false; # Install python3
        };

        rust = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = false;
        };

        cmake.enable = true;
        clangd.enable = true;

        git.enable = true;

        haskell.enable = true;
        docker = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = false;
        };
      };

      coding = {
        yanky.enable = true;
        luasnip.enable = true;
      };

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
