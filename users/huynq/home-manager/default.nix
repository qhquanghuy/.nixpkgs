{ username, homeDirectory }: { config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  home.username = username;
  home.homeDirectory = homeDirectory;

  home.sessionVariables = {
    EDITOR = "vim";
  };

  xdg = {
    enable = true;
    configHome = "${homeDirectory}/.nixpkgs/users/${username}/config-home";
  };

  home.packages =
    with pkgs; [
      thefuck
      (sbt.override { jre = jdk21_headless; })
      docker
      docker-compose
      docker-buildx
      # google-cloud-sdk
      postman
      postgresql
      colima
      jdk21_headless
      grpcurl
      terraform
      nodejs
      kubectl
      dbeaver-bin
      ngrok
      jq
      rover
      (spark.override { RSupport = false; })
      discord
      scala-cli
    ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Huy Nguyen";
    userEmail = "huynq@anymindgroup.com";
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
    '';
  };

  imports = [
    ./zsh.nix
  ];
}