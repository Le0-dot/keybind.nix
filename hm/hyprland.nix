{ lib, config, ... }:

let
  renderKeybind =
    {
      modifiers,
      key,
      action,
      type,
    }:
    "${builtins.concatStringsSep " " modifiers}, ${key}, exec, ${action}";
  keybindsByType = keybindType: builtins.filter ({ type, ... }: type == keybindType);
in
{
  options.keybind.hyprland.enable = lib.mkEnableOption "Hyprland keybinds";

  config = lib.mkIf config.keybind.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      bind = map renderKeybind (keybindsByType "PRESS" config.keybind.binds);
      binde = map renderKeybind (keybindsByType "HOLD" config.keybind.binds);
    };
  };
}
