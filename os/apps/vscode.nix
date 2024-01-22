{ programs, pkgs, ... }:
{
  home-manager.users.gen = {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        vscodevim.vim
        github.copilot
        github.copilot-chat
        piousdeer.adwaita-theme
        mechatroner.rainbow-csv
        editorconfig.editorconfig
        dendron.dendron
      ];

      userSettings = {
        "window.titleBarStyle" = "custom";
        "window.commandCenter" = true;
        "window.autoDetectColorScheme" = true;

        "workbench.preferredDarkColorTheme" = "Adwaita-dark";
        "workbench.preferredLightColorTheme" = "Adwaita-light";
        "workbench.productIconTheme" = "Adwaita";
        "workbench.iconTheme" = "Adwaita";
        "workbench.tree.indent" = 10;

        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 13;
        "editor.renderLineHighlight" = "none";
        "editor.minimap.enabled" = false;

        "console.fontFamily" = "Fira Code";
        "console.fontLigatures" = true;
        "console.fontSize" = 13;
      };
    };
  };
}
