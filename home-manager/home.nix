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
   #./home-manager - TODO figure out how to import waybar

  ];  

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
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
     libcanberra-gtk3                          #notification sound
     
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
        size = 12;
        draw_bold_text_with_bright_colors = true;
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
	    TERMINAL = "kitty";
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
