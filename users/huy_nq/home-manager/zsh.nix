{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    initExtraFirst = ''
      export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
      export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
      export DOCKER_HOST=unix://$HOME/.colima/docker.sock
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = lib.cleanSource "${config.xdg.configHome}/p10k-config";
        file = "p10k.zsh";
      }
    ];

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = ["git" "thefuck"];
    };

    initExtra = ''
      set -o vi
    '';
  };
}
