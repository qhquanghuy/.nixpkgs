{ pkgs, config, ... } : rec {
  users.users.huy_nq = {
  	name = "huy_nq";
  	home = "/Users/huy_nq";
	};

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.huy_nq = import ./home-manager {
      username = users.users.huy_nq.name;
      homeDirectory = users.users.huy_nq.home;
    };
  };


  # system.activationScripts.applications.text = pkgs.lib.mkForce (
  #   ''
  #     echo "setting up ~/Applications..." >&2
  #     rm -rf ~/Applications/Nix\ Apps
  #     mkdir -p ~/Applications/Nix\ Apps
  #     for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
  #       src="$(/usr/bin/stat -f%Y "$app")"
  #       cp -r "$src" ~/Applications/Nix\ Apps
  #     done
  #   ''
  # );

}
