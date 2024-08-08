{ config, pkgs, ... }:

{
    home.username = "esarver";
    home.homeDirectory = "/home/esarver";

    home.packages = with pkgs; [
        neofetch

        ripgrep
        eza
        fzf
        bat

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

    programs.helix = {
        enable = true;
        defaultEditor = true;
        extraPackages = [
            pkgs.nil
        ];
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
                    C = ["extend_to_line_end" "yank_main_selection_to_clipboard" "delete_selection" "insert_mode"];
                    D = ["extend_to_line_end" "yank_main_selection_to_clipboard" "delete_selection"];
                    S = "surround_add";

                    x = "delete_selection";
                    p = [ "paste_clipboard_after" "collapse_selection" ];
                    P = [ "paste_clipboard_before" "collapse_selection" ];
                    Y = ["extend_to_line_end" "yank_main_selection_to_clipboard" "collapse_selection"];

                    w = ["move_next_word_start" "move_char_right" "collapse_selection" ];
                    W = ["move_next_long_word_start" "move_char_right" "collapse_selection" ];
                    e = ["move_next_word_end" "collapse_selection"];
                    E = ["move_next_long_word_end" "collapse_selection"];
                    b = ["move_prev_word_start" "collapse_selection"];
                    B = ["move_prev_long_word_start" "collapse_selection"];

                    i = ["insert_mode" "collapse_selection"];
                    a = ["append_mode" "collapse_selection"];

                    esc = ["keep_primary_selection" "collapse_selection" ];

                    "*" = ["move_char_right" "move_prev_word_start" "move_next_word_end" "search_selection" "search_next"];
                    "#" = ["move_char_right" "move_prev_word_start" "move_next_word_end" "search_selection" "search_prev"];

                    j = "move_line_down";
                    k = "move_line_up";

                    d = {
                        d = ["extend_to_line_bounds" "yank_main_selection_to_clipboard" "delete_selection"];
                        t = ["extend_till_char"];
                        s = ["surround_delete"];
                        i = ["select_textobject_inner"];
                        a = ["select_textobject_around"];
                        j = ["select_mode" "extend_to_line_bounds" "extend_line_below" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
                        k = ["select_mode" "extend_to_line_bounds" "extend_line_above" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
                        G = ["select_mode" "extend_to_line_bounds" "goto_last_line" "extend_to_line_bounds" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode" ];
                        w = ["move_next_word_start" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
                        W = ["move_next_long_word_start" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
                        g.g = ["select_mode" "extend_to_line_bounds" "goto_file_start" "extend_to_line_bounds" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
                    };
                    };

                insert.esc = ["collapse_selection" "normal_mode"];

                select = {
                    "{" = ["extend_to_line_bounds" "goto_prev_paragraph"];
                    "}" = ["extend_to_line_bounds" "goto_next_paragraph"];
                    "0" = "goto_line_start";
                    "$" = "goto_line_end";
                    "^" = "goto_first_nonwhitespace";
                    G = "goto_file_end";
                    "%" = "match_brackets";
                    S = "surround_add";
                    u = ["switch_to_lowercase" "collapse_selection" "normal_mode"];
                    U = ["switch_to_uppercase" "collapse_selection" "normal_mode"];

                    i = "select_textobject_inner";
                    a = "select_textobject_around";

                    I = ["insert_mode" "collapse_selection"];
                    A = ["append_mode" "collapse_selection"];

                    k = "copy_selection_on_prev_line";
                    j = "copy_selection_on_next_line";
                    K = ["extend_line_up" "extend_to_line_bounds"];
                    J = ["extend_line_down" "extend_to_line_bounds"];

                    d = ["yank_main_selection_to_clipboard" "delete_selection"];
                    y = ["yank_main_selection_to_clipboard" "normal_mode" "flip_selections" "collapse_selection"];
                    Y = ["extend_to_line_bounds" "yank_main_selection_to_clipboard" "goto_line_start" "collapse_selection" "normal_mode"];
                    p = ["replace_selections_with_clipboard"];
                    P = ["paste_clipboard_before"];

                    esc = ["collapse_selection" "keep_primary_selection" "normal_mode"];
                };
            };
        };
    };

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
