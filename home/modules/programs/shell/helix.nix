{ pkgs, inputs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = inputs.helix-git.packages.${pkgs.system}.default;

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "nixfmt";
        language-servers = [
          "nixd"
          "nil"
        ];
      }

      {
        name = "markdown";
        auto-format = true;
        language-servers = [
          "marksman"
          "mpls"
        ];
      }
    ];

    languages.language-server.mpls = {
      command = "mpls";
      args = [
        "--dark-mode"
      ];
      # An example args entry showing how to specify flags with values:
      # args = ["--port", "8080", "--browser", "google-chrome", "--theme", "gruvbox-dark"]
    };

    settings = {
      editor.auto-save = {
        after-delay.enable = true;
        after-delay.timeout = 3000;
        focus-lost = true;
      };
      editor.file-explorer = {
        ignore = true;
      };
      keys.normal.space = {
        E = "file_explorer_in_current_directory";
        space = "@:cd <C-r>%<C-w><ret>";
      };
      # theme = "dark-synthwave";
      theme = "matugen-theme";
      # theme = "bogster";
    };
  };

  # xdg.configFile."helix/ignore".text = ''
  #   *.pyc
  #   **/__pycache__
  #   **/.venv
  #   **.pyc
  # '';

  home.packages = with pkgs; [
    # Nix LSP
    nil
    nixd
    nixfmt

    # Markdown LSP
    marksman
    mpls

    # Useful utilities
    scooter # interactive find and replace
  ];
}
