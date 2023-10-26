{ username, homeDirectory }: { config, pkgs, lib, fetchurl, ... }:

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
      (postman.overrideAttrs(old: rec {
        version = "10.18.10";
        src = pkgs.fetchurl {
          url = "https://dl.pstmn.io/download/version/${version}/osx_64";
          hash = "sha256-HY7K+f0KSxkEZ80sdEAFNXGIogkDXuvzEzB7rcSSIsg=";
          name = "${old.pname}-${version}.zip";
        };
      }))
      postgresql
      colima
      jdk8
      grpcurl
      terraform
      nodejs
      python3
      (ammonite.override { jre = jdk8; })
      dbeaver
      ngrok
      (spark.override { RSupport = false; hadoop = hadoop.override { openssl = openssl; }; })
      rustup
      nix-tree
      jq
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

  home.activation = {
    linkJdk = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD sudo ln -sf ${pkgs.jdk8.outPath} $VERBOSE_ARG /Library/Java/JavaVirtualMachines/jdk8
    '';
  };


  imports = [
    ./zsh.nix
    # ./home-manager-activation.nix
  ];
}
