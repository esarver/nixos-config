{ config, pkgs, ... }:

{
    home.username = "esarver";
    home.homeDirectory = "/home/esarver";

    home.packages = with pkgs; [
        neofetch

        ripgrep
        eza
        fzf
   
        lsof     # list open files
        usbutils # lsusb
        pciutils # lspci

        zellij
    ];

    programs.git = {
        enable = true;
        userName = "Edwin Sarver";
        userEmail = "edwin.l.sarver@gmail.com";
        extraConfig = {
            credential.helper = "${
                pkgs.git.override { withLibsecret = true; }
            }/bin/git-credential-libsecret";
        };
    };

    programs.bash = {
        enable = true;
        enableCompletion = true;
        bashrcExtra = ''
          export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin"
        '';
    };

    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
}
