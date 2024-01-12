# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

  hyprland-flake = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
  }).defaultNix;
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Mirror
  nix.settings.substituters = [ "https://hyprland.cachix.org" "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" "https://mirrors.ustc.edu.cn/nix-channels/store" ];
  nix.settings.trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Hardware
  powerManagement.cpuFreqGovernor = "powersave";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  networking.proxy.default = "http://192.168.0.2:7890/";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod = {
    enabled="fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-rime
    ];
  };

  #Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    hack-font
    wqy_microhei
    (nerdfonts.override { fonts = [ "Hack"]; })
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;
  #services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.awesome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shunlir = {
    isNormalUser = true;
    description = "shunlir";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
      kitty
    #  thunderbird
    ];
  };

  users.defaultUserShell = pkgs.zsh;

  # Enable automatic login for the user.
  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "shunlir";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Set default editor to vim
  environment.variables.EDITOR = "vim";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pstree
    dunst
    jq
    awesome
    remmina
    zoom-us
    logseq
    fd
    ripgrep
    eza
    gcc13
    fzf
    docker
    linuxKernel.packages.linux_6_1.cpupower
    pavucontrol
    brave
    zsh
    tmux
    neovim
    emacs
    git
    doublecmd
    wget
    neofetch
    btop
    wpsoffice
    mpv
    aria2
    intel-gpu-tools
    libva-utils
    blender
    handbrake
    slack
    # Wayland
    waybar
    bemenu
    wofi
    foot
    swappy
    grim
    slurp
    wev
    swaylock
    # Nix tools
    nix-tree
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.hyprland.enable = true;
  programs.hyprland.package = hyprland-flake.packages.${pkgs.system}.hyprland;
  programs.sway.enable = true;
  programs.zsh.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    intel-compute-runtime
  ];
  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
