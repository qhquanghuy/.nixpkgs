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
     export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
     export PATH="$PATH:$HOME/google-cloud-sdk/bin"
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
  };
}
