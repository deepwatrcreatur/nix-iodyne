# nix-iodyne

Nix package, flake, NixOS module, and Home Manager module for [iodyne](https://github.com/jbellis/iodyne).

`iodyne` is a single-host, read-only terminal view of storage behavior by Jonathan Ellis. It keeps all devices on comparable scales so busy or slow devices stand out immediately before inspecting numbers.

## Features

- **Capacity & IO views**: Volumes overview (filesystems / pools) and physical Devices overview.
- **Latency density lanes**: Read and write latency on a fixed logarithmic scale.
- **Topology & Facts**: Mounts, backing devices, mdraid, APFS, ZFS vdev, and SMART facts.
- **Embedded eBPF (Linux)**: When run as root (`sudo iodyne`), activates block latency histograms and VFS activity attribution by process and path without external daemons.
- **JSONL streaming**: Machine-readable structured traces with `--jsonl`.

## Quick Run

```bash
# Run directly with Nix
nix run github:deepwatrcreatur/nix-iodyne

# Run with privileged eBPF features on Linux
sudo nix run github:deepwatrcreatur/nix-iodyne
```

## Flake Integration

Add `nix-iodyne` to your `flake.nix` inputs:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-iodyne = {
      url = "github:deepwatrcreatur/nix-iodyne";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```

### NixOS Module

```nix
{ inputs, ... }: {
  imports = [ inputs.nix-iodyne.nixosModules.default ];

  programs.iodyne.enable = true;
}
```

### Home Manager Module

```nix
{ inputs, ... }: {
  imports = [ inputs.nix-iodyne.homeManagerModules.default ];

  programs.iodyne.enable = true;
}
```

### Overlay

```nix
{ inputs, ... }: {
  nixpkgs.overlays = [ inputs.nix-iodyne.overlays.default ];
  environment.systemPackages = [ pkgs.iodyne ];
}
```

## License

MIT (matching upstream `iodyne`).
