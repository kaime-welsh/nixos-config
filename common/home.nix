{
  pkgs,
  osConfig,
  ...
}:
{
  home.username = "kai";
  home.homeDirectory = "/home/kai";

  programs.git = {
    enable = true;
    settings = {
      user.name = "Kai";
      user.email = "kaime.r.welsh@gmail.com";
      init.defaultBranch = "main";
    };
  };

  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/nixos-config#${osConfig.networking.hostName}";
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      editor = {
        line-number = "relative";
        scroll-lines = 1;
        auto-pairs = true;
        bufferline = "always";

        indent-guides.render = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = true;
        };

        lsp = {
          display-messages = true;
        };
      };

      keys.normal = {
        g = {
          a = "code_action";
        };
        "ret" = [
          "move_line_down"
          "goto_first_nonwhitespace"
        ];
        X = "extend_line_above";
        D = "delete_char_backward";
        "[" = {
          b = ":bp";
        };
        "]" = {
          b = ":bn";
        };
        H = ":bp";
        L = ":bn";

        "C-S-B" = ":sh just build";
        "C-S-R" = ":sh just run";

        space = {
          q = ":wbc";
          e = [
            ":sh rm -f /tmp/unique-file-h21a434"
            ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-file-h21a434"
            ":insert-output echo \"x1b[?1049h\" > /dev/tty"
            ":open %sh{cat /tmp/unique-file-h21a434}"
            ":redraw"
            ":set mouse false"
            ":set mouse true"
          ];
          G = [
            ":write-all"
            ":insert-output lazygit >/dev/tty"
            ":redraw"
            ":reload-all"
          ];
        };
      };
    };
  };

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    extraConfig = ''
			keybinds {
        shared {
          bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
          bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
          bind "Alt j" "Alt Down" { MoveFocus "Down"; }
          bind "Alt k" "Alt Up" { MoveFocus "Up"; }
          bind "Alt m" { ToggleFloatingPanes; }
        }
      }
		'';
  };

  home.packages = with pkgs; [
    # General apps
    thunderbird
    firefox
    neofetch
    kdePackages.plasma-integration

    # Development
    nil
    git
    lazygit
    helix
    yazi
    zellij
    starship
    just
    ffmpeg
    imagemagick
    p7zip
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    resvg
    xsel
    xclip
    wl-clipboard
    netcat-gnu

    # Social
    signal-desktop
    vesktop
  ];

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };

  home.stateVersion = "25.11";
}
