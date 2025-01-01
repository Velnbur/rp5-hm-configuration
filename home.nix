{ ... }: {
  programs.helix.enable = true;
  programs.bat.enable = true;

  home.stateVersion = "25.05";
  home.username = "velnbur";

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
}
