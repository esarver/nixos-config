{ config, pkgs, ... }:

{
  home.username = "esarver";
  home.homeDirectory = "/home/esarver";

  home.packages = with pkgs; [

    ripgrep
    eza
    fzf
    bat

    lsof # list open files
    usbutils # lsusb
    pciutils # lspci

    zellij
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Edwin Sarver";
      user.email = "edwin.l.sarver@gmail.com";
      credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin"
    '';
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.nil
    ];
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        mouse = false;
        scrolloff = 8;
        cursorline = true;
        auto-format = true;
        auto-completion = true;
        rulers = [ 88 ];
        color-modes = true;
        default-line-ending = "lf";
        auto-pairs = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        lsp = {
          enable = true;
          display-messages = true;
        };
        indent-guides.render = true;
        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
          ];
        };
      };
      keys = {
      };
    };
  };

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
