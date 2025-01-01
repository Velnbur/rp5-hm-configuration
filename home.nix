{ pkgs, ... }: {
  programs.helix.enable = true;
  programs.bat.enable = true;

  home.stateVersion = "25.05";
  home.username = "velnbur";
  home.homeDirectory = "/home/velnbur";

  home.packages = (with pkgs; [
    qbittorrent-nox
  ]);

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
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
