rec {
  users.users.huynq = {
  	name = "huynq";
  	home = "/Users/huynq";
	};

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.huynq = import ./home-manager {
      username = users.users.huynq.name;
      homeDirectory = users.users.huynq.home;
    };
  };

}