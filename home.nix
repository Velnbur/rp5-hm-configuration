{ pkgs, ... }: rec {
  programs.helix.enable = true;
  programs.bat.enable = true;

  home.stateVersion = "25.05";
  home.username = "velnbur";
  home.homeDirectory = "/home/velnbur";

  home.packages = (with pkgs; [
    qbittorrent-nox
    samba
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

      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=8080 --save-path=/media/torrents --profile=${home.homeDirectory}/.config/qbittorrent";
    };
  };

  systemd.user.services.samba = {
    Unit = {
      Description = "smbd service";
      Documentation = [ "man:smbd(1)" ];
    };

    Service = {
      Type = "notify";
      ExecStart = "${pkgs.samba}/sbin/smbd --foreground --no-process-group --configfile=${home.homeDirectory}/.config/samba/samba.conf";
    };
  };

  home.file.".config/samba/samba.conf" = {
    enable = true;
    text = ''
      [global]
           server role = standalone server
           map to guest = Bad User
           usershare allow guests = yes
           hosts allow = 192.168.0.0/16
           hosts deny = 0.0.0.0/0
           log file = ${home.homeDirectory}/.local/logs/samba/%m.log
           state directory = ${home.homeDirectory}.local/state/samba
           cache directory = ${home.homeDirectory}.cache/samba
           lock directory = ${home.homeDirectory}.local/state/samba
           pid directory = ${home.homeDirectory}.local/state/samba


      [torrents]
           comment = Shared torrents
           guest ok = yes
           path = /media/torrents
           read only = yes
    '';
  };
}
