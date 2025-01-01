{ pkgs, ... }: rec {
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

  systemd.user.services.qbittorrent = {
    Unit = {
      Description = "qBittorrent-nox service";
      Documentation = [ "man:qbittorrent-nox(1)" ];
    };

    Service = {
      Type = "simple";

      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=8080 --save-path=/media/torrents --profile=$QBT_PROFILE";

      ExecStartPre =
        let
          preStartScript = pkgs.writeScript "qbittorrent-run-prestart" ''
            #!${pkgs.bash}/bin/bash

            # Create data directory if it doesn't exist
            if ! test -d "$QBT_PROFILE"; then
              echo "Creating initial qBittorrent data directory in: $QBT_PROFILE"
              install -d -m 0755 "$QBT_PROFILE"
            fi
          '';
        in
        "!${preStartScript}";

      Environment = "\"QBT_PROFILE='${home.homeDirectory}/.config/qbittorrent'\"";
    };
  };
}
