{ pkgs, ... }: {
  home.packages = [
    pkgs.yaml-language-server
  ];

  home.sessionVariables = {
    SUDO_EDITOR = "${pkgs.helix}/bin/hx";
  };

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
      truecolor = false;
    };
  };

  programs.eza.enable = true;
  programs.home-manager.enable = true;

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
  };
}
