self:
{ config, lib, pkgs, ... }:

let
  cfg = config.programs.iodyne;
in
{
  options.programs.iodyne = {
    enable = lib.mkEnableOption "iodyne - single-host disk IO, latency, topology, and health TUI";

    package = lib.mkOption {
      type = lib.types.package;
      default = self.packages.${pkgs.stdenv.hostPlatform.system}.default;
      defaultText = lib.literalExpression "inputs.nix-iodyne.packages.\${pkgs.stdenv.hostPlatform.system}.default";
      description = "The iodyne package to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
