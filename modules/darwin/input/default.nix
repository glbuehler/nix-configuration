{ config, lib, ... }:
let
  cfg = config.modules.darwin.input;
in
{

  options.modules.darwin.input = {
    enable = lib.mkEnableOption "enable darwin input settings";
  };

  config = lib.mkIf cfg.enable {
    system.defaults = {
      trackpad.TrackpadMomentumScroll = false;
      NSGlobalDomain = {
        InitialKeyRepeat = 20;
        KeyRepeat = 2;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
    };
    system.keyboard.enableKeyMapping = true;
    system.keyboard.userKeyMapping = [
      { # Left Command -> Left Control
        HIDKeyboardModifierMappingSrc = lib.fromHexString "0x7000000E3";
        HIDKeyboardModifierMappingDst = lib.fromHexString "0x7000000E4";
      }
      { # Right Option -> Right Control
        HIDKeyboardModifierMappingSrc = lib.fromHexString "0x7000000E6";
        HIDKeyboardModifierMappingDst = lib.fromHexString "0x7000000E4";
      }
    ];
  };

}
