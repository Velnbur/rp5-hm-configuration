{ ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
  programs.bat.enable = true;

  home.stateVersion = "25.05";
  home.username = "velnbur";
  home.homeDirectory = "/home/velnbur";

  programs.starship.enable = true;

  programs.zoxide = {
    enable = true;
    options = [ "--cmd" "cd" ];
  };

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };

  programs.eza.enable = true;
  programs.home-manager.enable = true;
}
