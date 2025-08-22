{ lib, ... }:

let
  keybind = lib.types.submodule {
    options = {
      modifiers = lib.mkOption {
        type = lib.types.listOf (
          lib.types.enum [
            "CTRL"
            "SHIFT"
            "ALT"
            "SUPER"
          ]
        );
        default = [ ];
        description = "List of modifier keys for keybind";
      };
      key = lib.mkOption {
        type = lib.types.str;
        description = "Trigger key for keybind";
      };
      action = lib.mkOption {
        type = lib.types.str;
        description = "Action to execute on keybind trigger";
      };
      type = lib.mkOption {
        type = lib.types.enum [
          "PRESS"
          "HOLD"
        ];
        default = "PRESS";
        description = "Type of keybind";
      };
    };
  };
in
{
  options.keybind.binds = lib.mkOption {
    type = lib.types.listOf keybind;
    default = [ ];
    example = [
      {
        modifiers = [ "SUPER" ];
        key = "F";
        action = "firefox";
      }
    ];
  };
}
