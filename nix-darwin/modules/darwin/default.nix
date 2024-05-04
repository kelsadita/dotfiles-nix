{ pkgs, self, ... }: {

      environment = {
        systemPackages =
          [
            pkgs.neovim
            pkgs.git
            pkgs.coreutils
            pkgs.rustup
          ];
        systemPath = [ "/opt/homebrew/bin" ];
        pathsToLink = [ "/Applications" ];
        variables = {
            EDITOR = "vim";
        };
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina

      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 4;
        keyboard.enableKeyMapping = true;
        defaults.NSGlobalDomain.InitialKeyRepeat = 10;
        defaults.NSGlobalDomain.KeyRepeat = 1;
      };

      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config.allowUnfree = true;
      };

      fonts = {
        fontDir.enable = true;
        fonts = [ pkgs.nerdfonts ]; 
      };

      # users
      users.users.kelsadita.home = "/Users/kelsadita";

      #homebrew
      homebrew = {
          enable = true;
          caskArgs.no_quarantine = true;
          global.brewfile = true;
          taps = [ "homebrew/cask-fonts" ];
          casks = [ "raycast" "amethyst" "font-zed-mono-nerd-font" "google-chrome" ];
        };
    }


