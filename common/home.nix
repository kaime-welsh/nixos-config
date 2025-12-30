{ pkgs, pkgs-stable, osConfig, inputs, ... }:
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
			* = {
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
      theme = "base16_transparent";

      editor = {
        line-number = "relative";
        scroll-lines = 1;
        auto-pairs = true;
        bufferline = "always";
        
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
        g = { a = "code_action"; };
        "ret" = [ "move_line_down" "goto_first_nonwhitespace" ];
        X = "extend_line_above";
        D = "delete_char_backward";
        "[" = { b = ":bp"; };
        "]" = { b = ":bn"; };
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
            ":insert-output gitui >/dev/tty"
            ":redraw"
            ":reload-all"
          ];
        };
      };
    };
  };	

	home.packages = with pkgs; [
		firefox
		neofetch

		ghostty
		helix
		neovim
		git
		gitui
		yazi
		zellij

		just
		netcat-gnu

		xclip
		wl-clipboard

		vesktop
		mangohud
		protonup-qt
	];

	home.stateVersion = "25.11";
}
