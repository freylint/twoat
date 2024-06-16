{ programs, pkgs, inputs, ... }:
{

  imports = [
    inputs.vscode-server.nixosModules.default
  ];

  services.vscode-server.enable = true;
  virtualisation.docker.enable = true;

  home-manager.users.gen = {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = true;

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        vscodevim.vim
        github.copilot
        github.copilot-chat
        piousdeer.adwaita-theme
        mechatroner.rainbow-csv
        ms-vscode-remote.remote-containers
        editorconfig.editorconfig
        vscode-icons-team.vscode-icons
        ms-vscode.cpptools
      ];

      userSettings = {
        "window.titleBarStyle" = "custom";
        "window.commandCenter" = true;
        "window.autoDetectColorScheme" = true;

        "workbench.preferredDarkColorTheme" = "Adwaita-dark";
        "workbench.preferredLightColorTheme" = "Adwaita-light";
        "workbench.productIconTheme" = "Adwaita";
        "workbench.iconTheme" = "vscode-icons";
        "workbench.tree.indent" = 10;

        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 13;
        "editor.renderLineHighlight" = "none";
        "editor.minimap.enabled" = false;

        "console.fontFamily" = "Fira Code";
        "console.fontLigatures" = true;
        "console.fontSize" = 13;

        "git.confirmSync" = false;

        "vsicons.dontShowNewVersionMessage" = true;
        "extensions.ignoreRecommendations" = true;
      };
    };
  };
}
