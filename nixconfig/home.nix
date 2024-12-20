{ config, pkgs, inputs, lib, ... }: {
	home.username = "xozu";
  home.homeDirectory = "/home/xozu";
  home.stateVersion = "24.05"; 
  imports = [ inputs.textfox.homeManagerModules.default ];

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ HYPRLAND SETUP ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;
		systemd = {
			enable = true;
			variables = ["--all"];
		};

# ✨ SETTINGS ✨

		settings = {
			"$mod" = "SUPER";
			"$terminal" = "kitty";
			"$fileManager" = "thunar";
			"exec-once" = [ "waybar" "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" "nm-applet" "blueman-applet" "xsetroot -cursor_name left_ptr" ];

# ✨ VARIABLES ✨

		env = [
      "HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors"
      "HYPRCURSOR_SIZE,24"
			"HYPRSHOT_DIR,$HOME/Pictures/Screenshots"
    ];

# ✨ MONITORS ✨

		monitor = [
			"eDP-1, 1920x1200@60, 0x0, 1"
			"HDMI-A-1, preffered, auto, 1"
		];

		workspace = [
			"1, monitor:eDP-1"
			"2, monitor:eDP-1"
			"3, monitor:eDP-1"
			"4, monitor:eDP-1"
			"5, monitor:eDP-1"
			"6, monitor:eDP-1"
			"7, monitor:eDP-1"
			"8, monitor:eDP-1"
			"9, monitor:HDMI-A-1"
		];        

# ✨ INPUTS ✨

		device = {
			name = "epic-mouse-v1";
			sensitivity = "-0.5";
		};

		gestures = {
			workspace_swipe = "on";
			workspace_swipe_cancel_ratio = 0;
			workspace_swipe_min_speed_to_force = 0;
			workspace_swipe_distance = 75;
		};

		input = {
			kb_layout = "us,sk";
			kb_variant = ",qwerty";
			kb_options = "caps:swapescape, grp:alt_shift_toggle";
			follow_mouse = "1";
			touchpad = {
				natural_scroll = "yes";
			};
		};

# ✨ DESIGN ✨

		general = {
			resize_on_border = true;
			gaps_in = 5;
			gaps_out = 7;
			border_size = 2;
			layout = "dwindle";
			allow_tearing = false;
		};

		decoration = {
			rounding = 5;
			blur = {
				enabled = true;
				size = 10;
				passes = 4;
			};
		dim_inactive = false;
		dim_strength = "0.2";
		inactive_opacity = "0.80";
		# active_opacity = "0.95";
		shadow = {
			enabled = "yes";
			range = 5;
			render_power = "1";
		};    
	};

		animations = {
			enabled = "yes";
			bezier = [
				"windowmove, 0.2, 0.75, 0.55, 1"
				"windowclose, 1, 0, 0, 1"
				"windowin, 0.01, 1, 0.5, 1"
				"workspacemove, 1, 1, 1, 1"
			];
			animation = [
				"windowsMove, 1, 6, windowmove"
				"windowsIn, 1, 7, windowin"
				"windowsOut, 0, 1, windowclose"
				"workspaces, 1, 0.001, default, slidevert"
			];
		};

		windowrule = "size,1300x400,title:Hyprland Polkit Agent";
		windowrulev2 = [ "suppressevent maximize, class:.*" "float, initialTitle: Mozilla Firefox, title:.*Bitwarden.*" ];
		dwindle = {
			pseudotile = "yes"; 
			preserve_split = "yes"; 
		};

		misc = {
			force_default_wallpaper = 0;
		};
		

# ✨ BINDS ✨

		bind = [
      "$mod SHIFT, F, togglefloating "
      "$mod, Q, killactive, "
      "$mod, F, fullscreen, "
      "$mod, H, togglesplit, "
      "$mod, O, exec, hyprctl setprop active opaque toggle "
      "$mod, P, exec, hyprpicker -a "
      "$mod, left, movefocus, l "
      "$mod, right, movefocus, r "
      "$mod, up, movefocus, u "
      "$mod, down, movefocus, d "
      "$mod, J, movefocus, l "
      "$mod, L, movefocus, r "
      "$mod, I, movefocus, u "
      "$mod, K, movefocus, d "
      "$mod SHIFT, left, movewindow, l "
      "$mod SHIFT, right, movewindow, r "
      "$mod SHIFT, up, movewindow, u "
      "$mod SHIFT, down, movewindow, d "
      "$mod SHIFT, H, movewindow, l "
      "$mod SHIFT, L, movewindow, r "
      "$mod SHIFT, I, movewindow, u "
      "$mod SHIFT, K, movewindow, d "
      "$mod, Tab, exec, $terminal "
      "$mod, E, exec, $fileManager "
      "$mod, M, exec, wlogout -b 2 "
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"
			", PRINT, exec, hyprshot -m region"
			"$mod, PRINT, exec, hyprshot -m output"
			"$mod,F10,pass,^(com\.obsproject\.Studio)$"
			"$mod,F11,pass,^(com\.obsproject\.Studio)$"
    ];

    bindr = [
      "$mod, $mod_L, exec, fuzzel"
     ];

    binde = [
    	"$mod CTRL, up, exec, hyprctl dispatch resizeactive 0 -20"
			"$mod CTRL, down, exec, hyprctl dispatch resizeactive 0 20"
			"$mod CTRL, left, exec, hyprctl dispatch resizeactive -20 0" 
			"$mainMod CTRL, right, exec, hyprctl dispatch resizeactive 20 0" 
			", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+"
			", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"
			", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			", xf86monbrightnessup, exec, brightnessctl set 10%+"
			", xf86monbrightnessdown, exec, brightnessctl set 10%-"
    ];

    bindm = [
    	"$mod, mouse:272, movewindow"
			"$mod, mouse:273, resizewindow"
		];
	 };
 };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ CURSORS ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# This is actually set also in Stylix, but here I also have the x11, so I'm just gonna keep both, they don't conflict or anything
	# home.pointerCursor = {
	# 	gtk.enable = true;
	# 	x11.enable = true;
	# 	name = "catppuccin-mocha-mauve-cursors";
	# 	size = 16;
	# };
 
# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ WAYBAR ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.waybar = {
		enable = true;
		settings = {
			mainBar = {
				position = "left";
				margin = "3px";
				width = 40;
 
				modules-left = ["hyprland/workspaces"];
				modules-center = ["clock"];
				modules-right = [ "wireplumber" "battery" "hyprland/language" "backlight" "tray" "custom/powermenu"];
				
# ✨ MODULES ✨

				"hyprland/language" = {
					"format" = "{}";
					"format-en" = "";
					"format-sk" = "";
				};

				"hyprland/workspaces" = {
					"format" = "<sub>{icon}</sub>\n{windows}";
					"format-window-separator" = "\n";
					"window-rewrite-default" = "";
					"window-rewrite" = {
						"Freetube" = "󰗃";
						"firefox" = "󰈹";
						"title<vim>" = "";
				  	"title<nvim>" = "";
						"title<.*hx.*>" = "󰚄";
						"title<home>" = "󰚄";
						"title<config>" = "󰚄";
						"title<flake>" = "󰚄";
				  	"class<kitty>" = "󰄛";
						"timeshift" = "󱫐";
						"gimp" = "";
						"mpv" = "";
						"mirage" = "";
						"evince" = "󰈙";
						"libre" = "";
						"onlyoffice" = "";
						"thunar" = "󰪶";
						"pavucontrol" = "󰗅";
						"zen" = "";
						"zathura" = "󱔗";
					};
				};

				"clock" = {
	        "format" = "{:%H\n%M}";
	        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
					"calendar" = {
						"format" = {
							"today" = "<span color='#7C69D2'><u>{}</u></span>";
						};
					};
		    };

				"wireplumber" = {
					"format-muted" = "";
					"format" = "{icon}";
					"states" = {
						"veryhigh" = 101;
						"max" = 150;
					};
					"on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
					"on-click-right" = "pavucontrol";
					"max-volume" = 150;
					"format-icons" = ["󰕿" "󰖀" "󱄠" "󰕾"];
					"reverse-scrolling" = true;
					"scroll-step" = 1;
					"rotate" = 90;
					"tooltip-format" = "{volume}%";
				};

				"battery" = {
					"states" = {
						"full" = 100;
						"normal" = 90;
						"warning" = 25;
						"critical" = 15;
					};
					"format" = "{icon}";
					"interval" = 5;
	        "format-icons" = { 
						"default" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
						"charging" = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
					};
					"tooltip-format" = "{capacity}%";
		    };

				"backlight" = {
					"device" = "intel_backlight";
					"format" = "{icon}";
					"states" = {
						"full" = 100;
					};
					"format-icons" = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];
					"on-scroll-down" = "brightnessctl s 5%-";
					"on-scroll-up" = "brightnessctl s +5%";
					"tooltip" = true;
					"tooltip-format" = "{percent}% ";
					"smooth-scrolling-threshold" = 1;
			  };

				"memory" = {
					"interval" = 60;
					"format" = "";
					"tooltip-format" = "{percentage}% RAM\n{swapPercentage}% SWAP";
				};

				"custom/powermenu" = {
					"format" = "󰐥";
					"tooltip" = false;
					"on-click" = "powermenu_t4";
				};
			};
		};
	};

# ✨ STYLE ✨

	programs.waybar.style = ''
		*{
		font-family: "JetBrainsMono Nerd Font,JetBrainsMono NF";
		font-size: 22px;
		font-weight: bold;
		}
	
		window#waybar {
			background: rgba(0,0,0,0);
		}

		#workspaces {
			padding: 10px 5px 20px 0px;
	  	border-bottom: 3px solid;
	  	border-bottom-left-radius: 5px;
	  	border-bottom-right-radius: 50px;
	  	border-top: 3px solid;
	  	border-top-left-radius: 50px;
	  	border-top-right-radius: 5px;
		}

		#workspaces button {
			padding: 0 5px;
	  	background-color: transparent;
		}

		#workspaces button.active {
			color: #7C69D2;
		}

		#clock {
			padding: 20px 5px 20px 5px;
	  	border-bottom: 3px solid;
	  	border-bottom-left-radius: 5px;
	  	border-bottom-right-radius: 50px;
	  	border-top: 3px solid;
	  	border-top-left-radius: 50px;
	  	border-top-right-radius: 5px;
		}

		#wireplumber {
			border-top: 3px solid @border;
	  	border-top-left-radius: 50px;
	  	border-top-right-radius: 5px;
			padding-top: 25px;
			padding-bottom: 10px;
		}

		#wireplumber.veryhigh {
			color: red;
		}

		#battery {
			padding-left: 1px;
		}

		#battery.warning:not(.charging) {
			color: #c98908;
		}

		#battery.critical:not(.charging) {
			color: #ff0000;
		}

		#backlight {
			padding-top: 10px;
			padding-right: 3px;
		}

		#memory {
			padding-right: 10px;
		}

		#backlight.full {
			color: yellow;
		}

		#tray {
			padding-bottom: 10px;
			padding-top: 10px;
			padding-left: 5px;
		}

		#custom-powermenu {
			color: #fa0018;
			padding-bottom: 15px;
			padding-left: 3px;
			border-bottom: 3px solid;
			border-color: white;
			border-bottom-left-radius: 5px;
			border-bottom-right-radius: 50px;
		}

		tooltip {
		  border: solid;
		  border-width: 1.5px;
		  border-radius: 8px;
		  border-color: #cdd6f4;
		}
		tooltip label {
		  color: #cdd6f4;
		  font-weight: normal;
		  margin: 0.25px;
		}

		#pulseaudio-slider,#wireplumber,#battery,
		#backlight,#tray,#custom-updates,
		#custom-powermenu,#clock,#workspaces,#language,#memory {
			background: #0e0c1a;
		}
	'';

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ TEXTFOX ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  textfox = {
    enable = true;
    profile = "xozu"; 
  };
  
# ┏━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ ZSH ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━┛ 

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		shellAliases = {
			ls = "eza";
			lst = "eza -T";
			lstl = "eza -T -l";
			c = "clear";
			cd = "z";
			update="cd $HOME/nixconfig && sudo nix flake update && sudo nixos-rebuild switch --flake ./#default && flatpak update";
			rebuild = "sudo nixos-rebuild switch --flake $HOME/nixconfig#default";
			listgen = "for profile in /nix/var/nix/profiles/system $HOME/.local/state/nix/profiles/profile $HOME/.local/state/nix/profiles/home-manager; do sudo nix-env --list-generations -p $profile; done";
			garbage = "for profile in /nix/var/nix/profiles/system $HOME/.local/state/nix/profiles/profile $HOME/.local/state/nix/profiles/home-manager; do sudo nix-env --delete-generations +5 -p $profile; done";
			wipe = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
			config = "cd $HOME/nixconfig && hx configuration.nix";
			home = "cd $HOME/nixconfig && hx home.nix";
			flake = "cd $HOME/nixconfig && hx flake.nix";
			hardware = "cd $HOME/nixconfig && hx hardware-configuration.nix";
			gitnix = "git --git-dir=$HOME/.GitNix --work-tree=$HOME";
			"gitnix-update" = "git --git-dir=$HOME/.GitNix --work-tree=$HOME add --update && dotfiles commit -m 'Update modified files' && dotfiles push";
			gitrollback = "git checkout HEAD^1";
			unzip = "file-roller --extract-here";
			error = "journalctl -u";
			convert = "magick";
			tree = "nix shell nixpkgs#nix-tree nixpkgs#ripgrep & nix-store --gc --print-roots | rg -v '/proc/' | rg -Po '(?<= -> ).*' | xargs -o nix-tree";
			"?" = "compgen -c | grep";
		};
		initExtra = ''
      cutvideo() {
		    # Check if the input file is provided
		    if [[ -z "$1" ]]; then
		        echo "Error: Input file not specified!"
		        echo "Usage: cutvideo <input_file>"
		        return 1
		    fi

		    input_file="$1"

		    # Check if the input file exists
		    if [[ ! -f "$input_file" ]]; then
		        echo "Error: Input file not found!"
		        return 1
		    fi

		    # Prompt the user for the start time
		    echo "Enter the start time in the format HH:MM:SS (e.g., 00:01:30 for 1 minute 30 seconds):"
		    read start_time

		    # Validate start time format
		    if [[ ! "$start_time" =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
		        echo "Error: Invalid time format. Please use HH:MM:SS."
		        return 1
		    fi

		    # Prompt the user for the end time
		    echo "Enter the end time in the format HH:MM:SS (e.g., 00:02:30 for 2 minutes 30 seconds):"
		    read end_time

		    # Validate end time format
		    if [[ ! "$end_time" =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
		        echo "Error: Invalid time format. Please use HH:MM:SS."
		        return 1
		    fi

		    # Prompt the user for the output file
		    echo -n "Enter the path and name for the output video file (e.g., output.mp4): "
		    read output_file

		    # Extract the output file format using `basename` and `cut`
		    output_format=$(basename "$output_file" | awk -F. '{print $NF}')

		    # Select the appropriate codec and perform cutting based on format
		    case "$output_format" in
		        mp4)
		            ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c:v libx264 -c:a aac -strict experimental "$output_file"
		            ;;
		        webm)
		            ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c:v libvpx -c:a libvorbis "$output_file"
		            ;;
		        avi)
		            ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c:v libxvid -c:a mp3 "$output_file"
		            ;;
		        mov)
		            ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c:v libx264 -c:a aac -strict experimental "$output_file"
		            ;;
		        mkv)
		            ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c:v libx264 -c:a aac "$output_file"
		            ;;
		        flv)
		            ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c:v libx264 -c:a aac "$output_file"
		            ;;
		        *)
		            echo "Unsupported output format: $output_format. Supported formats: .mp4, .webm, .avi, .mov, .mkv, .flv"
		            return 1
		            ;;
		    esac

		    # Notify the user about the successful cutting
		    if [[ $? -eq 0 ]]; then
		        echo "Video successfully cut and saved to: $output_file"
		    else
		        echo "Error occurred during video cutting."
		        return 1
		    fi
		}

			convertvideo() {
		    # Prompt the user for the desired output file format and name
		    echo -n "Enter the path and name for the output file (e.g., output.mp4): "
		    read output_file

		    # Extract the output file format using `basename` and `cut`
		    output_format=$(basename "$output_file" | awk -F. '{print $NF}')

		    # Prompt the user for desired quality (CRF)
		    echo "Choose the quality (CRF value):"
		    echo "  0 = Lossless (large file size)"
		    echo " 18 = Visually lossless (default for high quality)"
		    echo " 23 = Good balance of quality and file size"
		    echo "Higher values = Lower quality but smaller file size"
		    echo -n "Enter a CRF value (recommended: 18–23): "
		    read crf_value

		    # Validate CRF input
		    if ! [[ "$crf_value" =~ ^[0-9]+$ ]] || ((crf_value < 0 || crf_value > 51)); then
		        echo "Error: Invalid CRF value. It must be a number between 0 and 51."
		        return 1
		    fi

		    # Select the appropriate codec and perform conversion based on format
		    case "$output_format" in
		        mp4)
		            ffmpeg -i "$1" -c:v libx264 -crf "$crf_value" -preset medium -c:a aac -strict experimental "$output_file"
		            ;;
		        webm)
		            ffmpeg -i "$1" -c:v libvpx -crf "$crf_value" -b:v 1M -c:a libvorbis "$output_file"
		            ;;
		        avi)
		            ffmpeg -i "$1" -c:v libxvid -qscale:v 3 -c:a mp3 "$output_file"
		            ;;
		        mov)
		            ffmpeg -i "$1" -c:v libx264 -crf "$crf_value" -preset medium -c:a aac -strict experimental "$output_file"
		            ;;
		        mkv)
		            ffmpeg -i "$1" -c:v libx264 -crf "$crf_value" -preset medium -c:a aac "$output_file"
		            ;;
		        flv)
		            ffmpeg -i "$1" -c:v libx264 -crf "$crf_value" -preset medium -c:a aac "$output_file"
		            ;;
		        *)
		            echo "Unsupported output format: $output_format. Supported formats: .mp4, .webm, .avi, .mov, .mkv, .flv"
		            return 1
		            ;;
		    esac

		    # Notify the user about the successful conversion
		    if [[ $? -eq 0 ]]; then
		        echo "Video successfully converted to: $output_file"
		    else
		        echo "Error occurred during video conversion."
		        return 1
		    fi
		}
    '';
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ KITTY ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

	programs.kitty = {
		enable = true;
		themeFile = "tokyo_night_moon";
		shellIntegration.enableZshIntegration = true;
		settings = {
			confirm_os_window_close = 0;
			line_height = 1;
			use_font_shaping = true;
			selecion_background = "#6a6094";
			background_opacity = lib.mkForce 0.8;
		};
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ STARSHIP ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			format = "[](#a3aed2)[](bg:#a3aed2 fg:#090c0c)[](bg:#9f76f0 fg:#a3aed2)$directory[](fg:#9f76f0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$php[](fg:#212736 bg:#1d2230)$time[](fg:#1d2230)$character";
			directory = {
				style = "fg:#e3e5e5 bg:#9f76f0";
				format = "[ $path ]($style)";
				truncation_length = 3;
				truncation_symbol = "…/";
			};

			directory.substitutions = {
				"Documents" = "󰈙 ";
				"Downloads" = " ";
				"Music" = " ";
				"Pictures" = " ";
			};

			git_branch = {
				symbol = "";
				style = "bg:#394260";
				format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
			};

			git_status = {
				style = "bg:#394260";
				format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
			};

			nodejs = {
				symbol = "";
				style = "bg:#212736";
				format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
			};

			#the cute crab seems to be default symbol, make sure you have an emoji font installed like ttf-joypixels
			rust = {
				style = "bg:#212736";
				format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
			};

			golang = {
				symbol = "";
				style = "bg:#212736";
				format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
			};

			php = {
				symbol = "";
				style = "bg:#212736";
				format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
			};

			time = {
				disabled = false;
				time_format = "%R";
				style = "bg:#1d2230";
				format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
			};
		};
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ HELIX ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

	stylix.targets = {
		helix.enable = false;
		waybar.enable = false;
		fuzzel.enable = false;
	};

		programs.helix = {
		enable = true;
		defaultEditor = true;
		settings = {
			theme = "horizon-dark-custom";
			editor = {
				line-number = "relative";
				color-modes = true;
				true-color = true;
				bufferline = "multiple";
				cursor-shape = {
					insert = "bar";
					normal = "block";
					select = "underline";
				};
				file-picker = {
					hidden = false;
				};
				statusline = {
					left = [ "mode" "read-only-indicator" "file-modification-indicator" ];
					center = [ "file-name" ];
					right = [ "diagnostics" "position" ];
					separator = "│";
					mode = {
						normal = "NORMAL";
						insert = "O-RIDE";
						select = "SELECT";
					};
				};
			};
			keys = {
				normal = {
					j = "move_char_left";
					k = "move_visual_line_down";
					i = "move_visual_line_up";
					I = "half_page_up";
					K = "half_page_down";
					o = "insert_mode";
					O = "insert_at_line_start";
					"ret" = [ "open_below" "normal_mode" ];
					"S-ret" = [ "open_above" "normal_mode" ];
				};
				select = {
					j = "move_char_left";
					k = "move_visual_line_down";
					I = "half_page_up";
					K = "half_page_down";
					i = "move_visual_line_up";
					o = "insert_mode";
				};
			};
		};
		themes = {
			"horizon-dark-custom" = {
				inherits = "horizon-dark";
				"ui.background" = "#14131D";
				"ui.statusline.normal" = "#7C69D2";
				"ui.statusline.insert" = "#69D27C";
				"ui.statusline.select" = "#69A3D2";
				"ui.linenr" = "#696C90";
				"ui.linenr.selected" = "#7563C6";
			};
		};
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ PACKAGES ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

	programs.zathura.enable = true;
	programs.imv.enable = true;
	programs.obs-studio.enable = true;
	
# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ HOME MANAGER ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  programs.home-manager.enable = true;

  home.sessionVariables = {
		BROWSER = "firefox";
		TERMINAL = "kitty";
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ GTK ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━┛  

  gtk = {
    enable = true;
		iconTheme.package = pkgs.catppuccin-papirus-folders.override {
	    flavor = "mocha";
	    accent = "lavender";
	  };
		iconTheme.name = "Papirus-Dark";
  };

	qt = {
		enable = true;
		platformTheme.name = "qtct";
		style.name = "kvantum";
	};

	xdg.configFile = {
		"Kvantum/Catppuccin-Mocha-Mauve/Catppuccin-Mocha-Mauve/Catppuccin-Mocha-Mauve.kvconfig".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Mauve/Catppuccin-Mocha-Mauve.kvconfig";
		"Kvantum/Catppuccin-Mocha-Mauve/Catppuccin-Mocha-Mauve/Catppuccin-Mocha-Mauve.svg".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Mauve/Catppuccin-Mocha-Mauve.svg";
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ DUNST ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛   

  services.dunst = {
		enable = true;
  	settings = {
		  global = {
		    markup = "yes";
		    format = "<span foreground='#8d5bb4'><b>%s</b></span>\n%b";
		    sort = "yes";
		    indicate_hidden = "yes";
		    show_age_threshold = 60;
		    word_wrap = "yes";
		    ignore_newline = false;
		    origin = "top-center";
		    transparency = 0;
		    idle_threshold = 120;
		    monitor = 0;
		    follow = "mouse";
		    sticky_history = "yes";
		    line_height = 0;
		    separator_height = 2;
		    padding = 12;
		    horizontal_padding = 12;
		    corner_radius = 15;
		    frame_width = 1;
		    width = 400;
		    progress_bar_max_width = 400;
		    progress_bar_min_width = 400;
		    progress_bar_height = 10;
		    progress_bar_frame_width = 1;
		    progress_bar_corner_radius = 5;
		    scale = 1;
		    min_icon_size = 64;
		    max_icon_size = 64;
		    alignment = "center";
		    vertical_alignment = "center";
		  };
	    urgency_low = {
		    timeout = 5;
	    };
	    urgency_normal = {
		    timeout = 20;
	    };
	    urgency_critical = {
		    timeout = 0;
	    };
	  };
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ EZA ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━┛

	programs.eza = {
		enable = true;
		icons = "always";
		# extraOptions = [ "-T" ];
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ WLOGOUT ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.wlogout = {
		enable = true;
		layout = [
			{
		    label = "lock";
		    action = "hyprlock";
		    keybind = "x";
			}
			{
		    label = "reboot";
		    action = "systemctl reboot";
		    keybind = "r";
			}
			{
		    label = "logout";
		    action = "hyprctl dispatch exit";
		    keybind = "l";
			}
			{
		    label = "shutdown";
		    action = "systemctl poweroff";
		    keybind = "s";
			}
		];
		style = ''
		* {
    background-image: none;
    transition: 20ms;
    box-shadow: none;
		}

		window {
			background-color: rgba(0, 0, 0, 0.4);	
		}

		button {
	    color: #FFFFFF;
	    background-position: center;
	    background-repeat: no-repeat;
	    background-size: 20%;
	    border: none;
		  border-radius: 10px;
		  outline-style: none;
		}

		/* options */ 
		#lock {
	    background-color: #D3CFF9;
			background-image: url("/home/xozu/Pictures/config_pictures/wlogout/lock.png");
	    border-radius: 5px 0px 0px 0px;
	    margin : 200px 0px 0px 500px;
		}

		#reboot {
	    background-color: #9887E0;
			background-image: url("/home/xozu/Pictures/config_pictures/wlogout/reboot.png");
		  border-radius: 0px 0px 0px 5px;
	    margin : 0px 0px 200px 500px;
		}

		#logout {
	    background-color: #B5A6ED;
			background-image: url("/home/xozu/Pictures/config_pictures/wlogout/logout.png");
		  border-radius: 0px 5px 0px 0px;
	    margin : 200px 500px 0px 0px;
		}

		#shutdown {
	    background-color: #7C69D2;
			background-image: url("/home/xozu/Pictures/config_pictures/wlogout/shutdown.png");
		  border-radius: 0px 0px 5px 0px;
	    margin : 0px 500px 200px 0px;
		}

		/* options on hover */ 
		button:hover {
	    background-size: 25%;
		}

		button:hover#lock {
	    border-radius: 10px 10px 0px 10px;
	    margin : 150px 0px 0px 475px;
		}

		button:hover#reboot {
	    border-radius: 10px 0px 10px 10px;
	    margin : 0px 0px 150px 475px;
		}

		button:hover#logout {
	    border-radius: 10px 10px 10px 0px;
	    margin : 150px 475px 0px 0px;
		}

		button:hover#shutdown {
	    border-radius: 0px 10px 10px 10px;
	    margin: 0px 475px 150px 0px;
		}
		'';
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ MPV ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━┛

	programs = {
		mpv.enable = true;
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ NCMPCPP ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.ncmpcpp = {
		enable = true;
		mpdMusicDir = "~/music";
		settings = {
			mpd_host = "localhost";
			mpd_port = "6600";
			
		};
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ FUZZEL ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.fuzzel = {
		enable = true;
		settings = {
			main = {
				# prompt = "";
				font = "Iosevka Nerd Font";
				use-bold = true;
			};
			colors = {
				background = "24273add";
				text = "cad3f5ff";
				prompt = "b8c0e0ff";
				placeholder = "8087a2ff";
				input = "cad3f5ff";
				match = "c6a0f6ff";
				selection = "5b6078ff";
				selection-text = "cad3f5ff";
				selection-match = "c6a0f6ff";
				counter = "8087a2ff";
				border = "c6a0f6ff";
			};
			border = {
				width = 3;
				radius = 15;
			};
		};
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ FREETUBE ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.freetube = {
		enable = true;
		settings = {
			baseTheme = "catppuccinMocha";
			mainColor = "CatppuccinMochaLavender";
			secColor = "DeepPurple";
		};
	};
	
# ┏━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ GIT ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━┛

	programs.git = {
		enable = true;
		userName = "X07U";
		userEmail = "d4v0m1l@gmail.com";
		extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
			push = { autoSetupRemote = true; };
    };
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ OTHER ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛

	xdg.desktopEntries.onlyoffice-desktopeditors = {
		name = "OnlyOffice";
		genericName = "Document Editor";
		comment = "Edit office documents";
		type = "Application";
	  exec = "${pkgs.onlyoffice-desktopeditors}/bin/onlyoffice-desktopeditors --system-title-bar %U";
		terminal = false;
		icon = "onlyoffice-desktopeditors";
		categories = [ "Office" "WordProcessor" "Spreadsheet" "Presentation" ];
		mimeType = [ "application/vnd.oasis.opendocument.text" "application/vnd.oasis.opendocument.text-template" "application/vnd.oasis.opendocument.text-web" "application/vnd.oasis.opendocument.text-master" "application/vnd.sun.xml.writer" "application/vnd.sun.xml.writer.template" "application/vnd.sun.xml.writer.global" "application/msword" "application/vnd.ms-word" "application/x-doc" "application/rtf" "text/rtf" "application/vnd.wordperfect" "application/wordperfect" "application/vnd.openxmlformats-officedocument.wordprocessingml.document" "application/vnd.ms-word.document.macroenabled.12" "application/vnd.openxmlformats-officedocument.wordprocessingml.template" "application/vnd.ms-word.template.macroenabled.12" "application/vnd.oasis.opendocument.spreadsheet" "application/vnd.oasis.opendocument.spreadsheet-template" "application/vnd.sun.xml.calc" "application/vnd.sun.xml.calc.template" "application/msexcel" "application/vnd.ms-excel" "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" "application/vnd.ms-excel.sheet.macroenabled.12" "application/vnd.openxmlformats-officedocument.spreadsheetml.template" "application/vnd.ms-excel.template.macroenabled.12" "application/vnd.ms-excel.sheet.binary.macroenabled.12" "text/csv" "text/spreadsheet" "application/csv" "application/excel" "application/x-excel" "application/x-msexcel" "application/x-ms-excel" "text/comma-separated-values" "text/tab-separated-values" "text/x-comma-separated-values" "text/x-csv" "application/vnd.oasis.opendocument.presentation" "application/vnd.oasis.opendocument.presentation-template" "application/vnd.sun.xml.impress" "application/vnd.sun.xml.impress.template" "application/mspowerpoint" "application/vnd.ms-powerpoint" "application/vnd.openxmlformats-officedocument.presentationml.presentation" "application/vnd.ms-powerpoint.presentation.macroenabled.12" "application/vnd.openxmlformats-officedocument.presentationml.template" "application/vnd.ms-powerpoint.template.macroenabled.12" "application/vnd.openxmlformats-officedocument.presentationml.slide" "application/vnd.openxmlformats-officedocument.presentationml.slideshow" "application/vnd.ms-powerpoint.slideshow.macroEnabled.12" "x-scheme-handler/oo-office" "text/docxf" "text/oform" "application/pdf" ];
		actions = {
			"NewDocument" = {
				exec = "${pkgs.onlyoffice-desktopeditors}/bin/onlyoffice-desktopeditors --new:word";
			};
			"NewSpreadsheet" = {
				exec = "${pkgs.onlyoffice-desktopeditors}/bin/onlyoffice-desktopeditors --new:cell";
			};
			"NewPresentation" = {
				exec = "${pkgs.onlyoffice-desktopeditors}/bin/onlyoffice-desktopeditors --new:slide";
			};
			"NewForm" = {
				exec = "${pkgs.onlyoffice-desktopeditors}/bin/onlyoffice-desktopeditors --new:form";
			};
		};
	};

	programs.btop.enable = true;

	programs.zoxide.enable = true;

	dconf.settings = {
	  "org/virt-manager/virt-manager/connections" = {
	    autoconnect = ["qemu:///system"];
	    uris = ["qemu:///system"];
	  };
	};
	
}
