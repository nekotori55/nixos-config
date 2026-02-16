{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) str bool;

  cfg = config.modules.ollama;
in
{
  options.modules.ollama = {
    enable = mkEnableOption "Enable ollama";
    acceleration = mkOption {
      type = str;
      description = "same as services.ollama.acceleration";
      default = "";
    };
    web-ui = mkOption {
      type = bool;
      default = true;
      description = "Enable open-webui";
    };
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = pkgs."ollama-${cfg.acceleration}";

      environmentVariables.OLLAMA_KEEP_ALIVE = "5m";
    };

    services.open-webui = mkIf cfg.web-ui {
      enable = true;
      port = 8080;

      environment = {
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
        ENABLE_RAG_WEB_SEARCH = "True";
        RAG_WEB_SEARCH_ENGINE = "duckduckgo";
      };
    };
  };
}
