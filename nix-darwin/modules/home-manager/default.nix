{pkgs, ...}:

{
  home = {
    stateVersion = "24.05";
    packages = [ pkgs.ripgrep pkgs.fd pkgs.curl pkgs.less pkgs.kitty pkgs.obsidian pkgs.rustup ];
    sessionVariables = {
      PAGER = "less";
      CLICOLOR = 1;
      EDITOR = "nvim";
    };
    file.".inputrc".source = ./dotfiles/inputrc;
  };
  programs = {
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    git.enable = true;
    eza.enable = true;
    zsh =  {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "ls --color=auto -F";
        nixswitch = "darwin-rebuild switch --flake ~/.config/nix-darwin/flake.nix";
        vim = "nvim";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    alacritty = {
      enable = true;
      settings.font = {
          size = 16;
          normal.family = "ZedMono Nerd Font";
      };
    };
    wezterm = {
      enable = true;
      extraConfig = ''
        -- Pull in the wezterm API
        local wezterm = require 'wezterm'

        -- This will hold the configuration.
        local config = wezterm.config_builder()

        -- This is where you actually apply your config choices

        -- For example, changing the color scheme:
        config.color_scheme = 'Batman'

        config.font = wezterm.font "ZedMono Nerd Font"

        -- and finally, return the configuration to wezterm
        return config
      '';
    };
  };
}
