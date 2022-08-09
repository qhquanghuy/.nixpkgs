{ username, homeDirectory }: { config, pkgs, lib, ... }:

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
      vscode
      thefuck
      (sbt.override { jre = jdk8; })
      docker
      docker-compose
      google-cloud-sdk
      awscli2
      aws-vault
      postman
      postgresql
      colima
      jdk8
      grpcurl
      terraform
      nodejs
      python3
      (ammonite.override { jre = jdk8; })
      dbeaver
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
    userEmail = "huy_ngq@flinters.vn";
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
    # ./home-manager-activation.nix
  ];
}
