{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "grmhay";
  home.homeDirectory = "/home/grmhay";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  imports = [
    #./waybar/waybar.nix
    #<home-manager/nixos>
  ];  

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    # TODO does this change font size? changed from 16
    "Xcursor.size" = 12;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch

    # Neovim
    neovim
    lua-language-server

    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    tmux
    wttrbar # Weather module - https://github.com/bjesus/wttrbar

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    # Hyprland related
    swaylock-effects swayidle wlogout swaybg  #Login etc..
    hyprland-protocols
    libsForQt5.qt5.qtwayland
    rofimoji
    dunst                                     #notifications
    jellyfin-ffmpeg                           #multimedia libs

    viewnior                                  #image viewr
    pavucontrol                               #Volume control
    ####GTK Customization####
     nordic
     papirus-icon-theme
     gtk3
     glib
     xcur2png
     rubyPackages.glib2
     nwg-look				       #control fonts etc in hyprland default apps - GTK settings in launcher
     libcanberra-gtk3                          #notification sound
     # Audio
     pamixer

     # Waybar dependencies
     gtkmm3
     jsoncpp
     libsigcxx  #libsigc++
     fmt
     wayland
     #chrono-date # Cannot find in nixpkg
     spdlog
     #libgtk-3-dev #[gtk-layer-shell] cannot find in nixpkg
     gobject-introspection #[gtk-layer-shell]
     #libgirepository1.0-dev #[gtk-layer-shell] cannot find in nixpkg
     libpulseaudio #[Pulseaudio module]
     libnl #[Network module]
     libappindicator-gtk3 #[Tray module]
     libdbusmenu-gtk3 #[Tray module]
     libmpdclient #[MPD module]
     # libsndio #[sndio module] - cannot find in nixpkgs
     libevdev #[KeyboardState module]
     # xkbregistry - cannot find in nixpkgs
     upower #[UPower battery module]
     
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Graeme Hay";
    userEmail = "grmhay@gmail.com";
  };

  #rofi
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    plugins = [pkgs.rofimoji];
    configPath = ".config/rofi/config.rasi";
    theme = "simple-tokyonight.rasi";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 10;
        #draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

      #Session variables
     home.sessionVariables = {
	    BROWSER = "firefox";
	    EDITOR = "nvim";
	    TERMINAL = "alacritty";
	    #NIXOS_OZONE_WL = "1";
	    QT_QPA_PLATFORMTHEME = "gtk3";
	    QT_SCALE_FACTOR = "1.25";
	    MOZ_ENABLE_WAYLAND = "1";
	    SDL_VIDEODRIVER = "wayland";
	    _JAVA_AWT_WM_NONREPARENTING = "1";
	    QT_QPA_PLATFORM = "wayland-egl";
	    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
	    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
            MOZ_DRM_DEVICE= "/dev/dri/card0:/dev/dri/card1
";
	    WLR_DRM_DEVICES = "/dev/dri/card0:/dev/dri/car
d1";
	    #WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor uncomment this line
	    GBM_BACKEND = "nvidia-drm";
	    CLUTTER_BACKEND = "wayland";
	    LIBVA_DRIVER_NAME = "iHD";
	    WLR_RENDERER = "vulkan";
            VK_DRIVER_FILES="/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
            
	    #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
	    #__NV_PRIME_RENDER_OFFLOAD="1";
	    XDG_CURRENT_DESKTOP = "Hyprland";
	    XDG_SESSION_DESKTOP = "Hyprland";
	    XDG_SESSION_TYPE = "wayland";
	    GTK_USE_PORTAL = "1";
	    #NIXOS_XDG_OPEN_USE_PORTAL = "1";
	    XDG_CACHE_HOME = "\${HOME}/.cache";
	    XDG_CONFIG_HOME = "\${HOME}/.config";
	    #XDG_BIN_HOME = "/etc/profiles/per-user/{user}/bin";
	    XDG_BIN_HOME = "/etc/profiles/per-user/grmhay/bin";
	    XDG_DATA_HOME = "\${HOME}/.local/share";

    };

programs.waybar = {
	enable = true;
	package = pkgs.waybar;
	settings = {
        mainBar = {
            height = 20; # Doesn't seem to change bar height!
            layer = "top";
            modules-left = ["custom/launcher" "cpu" "memory" "hyprland/workspaces"];
            modules-center = ["mpris"];
            modules-right = ["network" "pulseaudio" "backlight" "battery" "custom/weather" "clock" "tray" "custom/wallpaper" "custom/power-menu"];

          "hyprland/workspaces" = {
            format = "{name}";
            all-outputs = true;
            on-click = "activate";
            format-icons = {
              active = " 󱎴";
              default = "󰍹";
            };
            persistent-workspaces = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
              "5" = [];
            };
          };
          "hyprland/language" = {
            format = "{short}";
          };

          "hyprland/window" = {
            max-length = 200;
            separate-outputs = true;
          };
          "tray" = {
            spacing = 10;
          };
          "clock" = {
            format = "{:%H:%M}";
            format-alt = "{:%b %d %Y}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          "cpu" = {
            interval = 10;
            format = "  {}%";
            max-length = 10;
            on-click = "";
          };
          "memory" = {
            interval = 30;
            format = " {}%";
            format-alt = " {used:0.1f}GB";
            max-length = 10;
          };
          "backlight" = {
            device = "intel_backlight";
            format = "{icon}";
            tooltip = true;
            format-alt = "<small>{percent}%</small>";
            format-icons = ["󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
            on-scroll-up = "brightnessctl set 1%+";
            on-scroll-down = "brightnessctl set 1%-";
            smooth-scrolling-threshold = "2400";
            tooltip-format = "Brightness {percent}%";
          };
          "network" = {
            format-wifi = "<small>{bandwidthDownBytes}</small> {icon}";
            min-length = 10;
            fixed-width = 10;
            format-ethernet = "󰈀";
            format-disconnected = "󰤭";
            tooltip-format = "{essid}";
            interval = 1;
            on-click = "~/.config/waybar/scripts/network/rofi-network-manager.sh"; # TODO - not working
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          };

          # TODO - maybe need to enable bluetooth support on Framework as not appearing?
          "bluetooth" = {
            format = "{icon}";
            format-alt = "bluetooth: {status}";
            interval = 30;
            format-icons = {
              enabled = "";
              disabled = "󰂲";
            };
            tooltip-format = "{status}";
          };

          "pulseaudio" = {
            format = "{icon}";
            format-muted = "󰖁";
            format-icons = {
              default = ["" "" "󰕾"];
            };
            on-click = "pamixer -t";
            on-scroll-up = "pamixer -i 1"; # TODO - not working
            on-scroll-down = "pamixer -d 1"; # TODO - not working
            on-click-right = "exec pavucontrol";
            tooltip-format = "Volume {volume}%";
          };

          "battery" = {
            interval = 60;
            states = {
              warning = 20;
              critical = 15;
            };
            max-length = 20;
            format = "{icon}";
            format-warning = "{icon}";
            format-critical = "{icon}";
            format-charging = "<span font-family='Font Awesome 6 Free'></span>";
            format-plugged = "󰚥";
            format-notcharging = "󰚥";
            format-full = "󰂄";

            format-alt = "<small>{capacity}%</small> ";
            format-icons = ["󱊡" "󱊢" "󱊣"];
          };

          "custom/weather" =  {
            format =  "{}°";
            tooltip =  true;
            interval =  3600;
            exec = "wttrbar --location Phoenix --fahrenheit --mph"; 
            return-type = "json";
          };

          "mpris" = {
            format = "{player_icon} {title}";
            format-paused = " {status_icon} <i>{title}</i>";
            max-length = 80;
            player-icons = {
              default = "▶";
              mpv = "🎵";
            };
            status-icons = {
              paused = "⏸";
            };
          };
          # TODO - Music player doesn't work
          "custom/spotify" = {
            exec = "nix-shell ~/.config/waybar/scripts/mediaplayer.py --player youtube-music";
            format = " {}";
            return-type = "json";
            on-click = "playerctl play-pause";
            on-double-click-right = "playerctl next";
            on-scroll-down = "playerctl previous";
          };

          "custom/power-menu" = {
            format = "{percentage}Hz";
            on-click = "~/.config/hypr/scripts/screenHz.sh";
            return-type = "json";
            exec = "cat ~/.config/hypr/scripts/hz.json";
            interval = 1;
            tooltip = false;
          };

          "custom/launcher" = {
            format = "󱄅";
            on-click = "rofi -show drun &";
          };

          "custom/wallpaper" = {
            format = "󰸉";
            on-click = "bash ~/.config/waybar/scripts/changewallpaper.sh";
          };
          };
          };
        style = '' 
                  * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: Material Design Icons, JetBrainsMono Nerd Font, Iosevka Nerd Font ;
            font-size: 14px;
            border: none;
            border-radius: 0;
            min-height: 0;
          }

          window#waybar {
            background-color: rgba(26, 27, 38, 0.5);
            color: #ffffff;
            transition-property: background-color;
            transition-duration: 0.5s;
          }

          window#waybar.hidden {
            opacity: 0.1;
          }

          #window {
            color: #64727d;
          }

          #clock,
          #temperature,
          #mpris, 
          #cpu,
          #memory,
          #custom-media,
          #tray,
          #mode,
          #custom-lock,
          #workspaces,
          #idle_inhibitor,
          #custom-launcher,
          #custom-spotify,
          #custom-weather,
          #custom-weather.severe,
          #custom-weather.sunnyDay,
          #custom-weather.clearNight,
          #custom-weather.cloudyFoggyDay,
          #custom-weather.cloudyFoggyNight,
          #custom-weather.rainyDay,
          #custom-weather.rainyNight,
          #custom-weather.showyIcyDay,
          #custom-weather.snowyIcyNight,
          #custom-weather.default {
            color: #e5e5e5;
            border-radius: 6px;
            padding: 2px 10px;
            background-color: #252733;
            border-radius: 8px;
            font-size: 16px;

            margin-left: 4px;
            margin-right: 4px;

            margin-top: 8.5px;
            margin-bottom: 8.5px;
          }
          #temperature{
            color: #7a95c9;
          }
          #cpu {
            color: #fb958b;
          }

          #memory {
            color: #a1c999;
          }

          #workspaces button {
            color: #7a95c9;
            box-shadow: inset 0 -3px transparent;

            padding-right: 3px;
            padding-left: 4px;

            margin-left: 0.1em;
            margin-right: 0em;
            transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
          }

          #workspaces button.active {
            color: #ecd3a0;
            padding-left: 1px;
            padding-right: 5px;
            font-family: Iosevka Nerd Font;
            font-weight: bold;
            font-size: 12px;
            margin-left: 0em;
            margin-right: 0em;
            transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
          }

          #custom-launcher {
            margin-left: 12px;

            padding-right: 18px;
            padding-left: 14px;

            font-size: 22px;

            color: #7a95c9;

            margin-top: 8.5px;
            margin-bottom: 8.5px;
          }
          #bluetooth,
          #backlight,
          #battery,
          #pulseaudio,
          #network {
            background-color: #252733;
            padding: 0em 2em;

            font-size: 14px;

            padding-left: 7.5px;
            padding-right: 7.5px;

            padding-top: 3px;
            padding-bottom: 3px;

            margin-top: 7px;
            margin-bottom: 7px;
            
            font-size: 20px;
          }

          #pulseaudio {
            color: #81A1C1;
            padding-left: 9px;
            font-size: 22px;
          }

          #pulseaudio.muted {
            color: #fb958b;
            padding-left: 9px;
            font-size: 22px;
          }

          #backlight {
            color: #ecd3a0;
            padding-right: 5px;
            padding-left: 8px;
            font-size: 21.2px;
          }

          #network {
            padding-left: 0.2em;
            color: #5E81AC;
            border-radius: 8px 0px 0px 8px;
            padding-left: 14px;
            padding-right: 14px;
            font-size: 20px;
          }

          #network.disconnected {
            color: #fb958b;
          }

          #bluetooth {
            padding-left: 0.2em;
            color: #5E81AC;
            border-radius: 8px 0px 0px 8px;
            padding-left: 14px;
            padding-right: 14px;
            font-size: 20px;
          }

          #bluetooth.disconnected {
            color: #fb958b;
          }


          #battery {
            color: #8fbcbb;
            border-radius: 0px 8px 8px 0px;
            padding-right: 12px;
            padding-left: 12px;
            font-size: 22px;
          }

          #battery.critical,
          #battery.warning,
          #battery.full,
          #battery.plugged {
            color: #8fbcbb;
            padding-left: 12px;
            padding-right: 12px;
            font-size: 22px;
          }

          #battery.charging { 
            font-size: 18px;
            padding-right: 12px;
            padding-left: 12px;
          }

          #battery.full,
          #battery.plugged {
            font-size: 22.5px;
            padding-right: 12px;
          }

          @keyframes blink {
            to {
              background-color: rgba(30, 34, 42, 0.5);
              color: #abb2bf;
            }
          }

          #battery.warning {
            color: #ecd3a0;
          }

          #battery.critical:not(.charging) {
            color: #fb958b;
          }

          #custom-lock {
            color: #ecd3a0;
            padding: 0 15px 0 15px;
            margin-left: 7px;
            margin-top: 7px;
            margin-bottom: 7px;
          }
          #clock {
            color: #8a909e;
            font-family: Iosevka Nerd Font;
            font-weight: bold;
            margin-top: 7px;
            margin-bottom: 7px;
          }
          #language {
            color: #8a909e;
            font-family: Iosevka Nerd Font;
            font-weight: bold;
            border-radius : 8px 0 0 8px;
            margin-top: 7px;
            margin-bottom: 7px;
          }

          #custom-power-menu {
            color: #8a909e;
            margin-right: 12px;
            border-radius: 8px;
            padding: 0 6px 0 6.8px;
            border-radius: 0 8px 8px 0;
            margin-top: 7px;
            margin-bottom: 7px;
          }
          #custom-wallpaper {
            color: #8a909e;
            padding-right: 7;
            padding-left: 7;
          }
          #custom-wallpaper,
          #language,
          #custom-power-menu {
            background-color: #252733;
            padding: 0em 2em;

            font-size: 17px;

            padding-left: 7.5px;
            padding-right: 7.5px;

            padding-top: 3px;
            padding-bottom: 3px;

            margin-top: 7px;
            margin-bottom: 7px;
          }

          tooltip {
            font-family: Iosevka Nerd Font;
            border-radius: 15px;
            padding: 15px;
            background-color: #1f232b;
          }

          tooltip label {
            font-family: Iosevka Nerd Font;
            padding: 5px;
          }

          label:focus {
            background-color: #1f232b;
          }

          #tray {
            margin-right: 8px;
            margin-top: 7px;
            margin-bottom: 7px;
            font-size: 30px;

          }

          #tray > .passive {
            -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: #eb4d4b;
          }

          #idle_inhibitor {
            background-color: #242933;
          }

          #idle_inhibitor.activated {
            background-color: #ecf0f1;
            color: #2d3436;
          }
          #mpris,
          #custom-spotify {
            color: #abb2bf;
          }

          #custom-weather {
            font-family: Iosevka Nerd Font;
            font-size: 19px;
            color: #8a909e;
          }

          #custom-weather.severe {
            color: #eb937d;
          }

          #custom-weather.sunnyDay {
            color: #c2ca76;
          }

          #custom-weather.clearNight {
            color: #cad3f5;
          }

          #custom-weather.cloudyFoggyDay,
          #custom-weather.cloudyFoggyNight {
            color: #c2ddda;
          }

          #custom-weather.rainyDay,
          #custom-weather.rainyNight {
            color: #5aaca5;
          }

          #custom-weather.showyIcyDay,
          #custom-weather.snowyIcyNight {
            color: #d6e7e5;
          }

          #custom-weather.default {
            color: #dbd9d8;
          }
    '';
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
