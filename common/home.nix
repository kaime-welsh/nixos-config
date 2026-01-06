{
  pkgs,
  pkgs-stable,
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
    enableDefaultConfig = false;
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
    enableCompletion = true;
    initExtra = ''
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        command yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }
    '';
    shellAliases = {
      update = "cd ~/nixos-config && git fetch && git pull && sudo nixos-rebuild switch --flake ~/nixos-config#${osConfig.networking.hostName}; cd -";
      config = "cd ~/nixos-config && hx ./";
      ls = "lsd -la";
      cd = "z";
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      editor = {
        # theme = "base16_terminal";
        line-number = "relative";
        scroll-lines = 1;
        auto-pairs = true;
        bufferline = "always";

        indent-guides.render = true;

        auto-format = true;

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
    settings = {
      default_mode = "locked";
      show_startup_tips = false;
    };
    extraConfig = ''
          keybinds {
            shared {
              bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
              bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
              bind "Alt j" "Alt Down" { MoveFocus "Down"; }
              bind "Alt k" "Alt Up" { MoveFocus "Up"; }
              bind "Alt f" { ToggleFloatingPanes; }
              bind "Alt t" { NewTab; }
              bind "Alt p" { NewPane; }
            }
          }
      	'';
  };

  programs.yazi = {
    enable = true;
  };

  programs.starship.enable = true;
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  home.packages = with pkgs; [
    # General apps
    pkgs-stable.anytype
    onlyoffice-desktopeditors
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
    lsd
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
    pkgs-stable.anytype
    signal-desktop
    vesktop

    # Util
    kdePackages.kcalc
  ];

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };

  home.stateVersion = "25.11";
}
