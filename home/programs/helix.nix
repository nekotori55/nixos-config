{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "nixfmt-rfc-style";
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
      theme = "dark-synthwave";
    };
  };

  home.packages = with pkgs; [
    # Nix LSP
    nil
    nixd
    nixfmt-rfc-style

    # Markdown LSP
    marksman
    mpls
  ];
}
