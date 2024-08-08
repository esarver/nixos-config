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

    programs.helix {
        enable = true;
        defaultEditor = true;
        settings = {
            theme = "gruvbox";
            editor = {
                line-number = "relative";
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
                    left = ["mode" "spinner" "version-control" "file-name"];
                };
            };
            keys = {
                normal = {
                    # Some nice Helix stuff
                    C-h = "select_prev_sibling";
                    C-j = "shrink_selection";
                    C-k = "expand_selection";
                    C-l = "select_next_sibling";

                    "{" = [ "goto_prev_paragraph" "collapse_selection" ];
                    "}" = [ "goto_next_paragraph" "collapse_selection" ];
                    "0" = "goto_line_start";
                    "$" = "goto_line_end";
                    "^" = "goto_first_nonwhitespace";
                    G = "goto_file_end";
                    "%" = "match_brackets";
                    V = ["select_mode" "extend_to_line_bounds"];
                    C = ["extend_to_line_end" "yank_main_selection_to_clipboard", "delete_selection" "insert_mode"];
                    D = ["extend_to_line_end" "yank_main_selection_to_clipboard", "delete_selection"];
                    S = "surround_add"
                };
            };
        };
    };

    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
}
