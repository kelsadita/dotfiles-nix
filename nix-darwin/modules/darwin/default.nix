{ pkgs, self, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.neovim
          pkgs.git
          pkgs.coreutils
        ];
      environment.systemPath = [ "/opt/homebrew/bin" ];
      environment.pathsToLink = [ "/Applications" ];
      environment.variables = {
          EDITOR = "vim";
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      #programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;
      system.keyboard.enableKeyMapping = true;
      system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
      system.defaults.NSGlobalDomain.KeyRepeat = 1;


      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Setting allow unfree to true
      nixpkgs.config.allowUnfree = true;

      # fonts
      fonts.fontDir.enable = true;
      fonts.fonts = [ pkgs.nerdfonts ]; 

      # users
      users.users.kelsadita.home = "/Users/kelsadita";

      #homebrew
      homebrew = {
          enable = true;
          caskArgs.no_quarantine = true;
          global.brewfile = true;
          casks = [ "raycast" "amethyst" ];
        };
    }


