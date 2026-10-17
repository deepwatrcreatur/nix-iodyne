{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "iodyne";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "jbellis";
    repo = "iodyne";
    rev = "v${version}";
    hash = "sha256-Dvd4MNEXqFStLPlqgfjAuRWoGKnco1fKnvqslt95gM8=";
  };

  cargoHash = "sha256-W8wevx9KOuacm1/kSbWtw3MVU4XxctPfBGV4ub5Kay4=";

  meta = with lib; {
    description = "Single-host, read-only disk IO, latency, topology, and health TUI";
    longDescription = ''
      iodyne is a single-host, read-only terminal view of storage behavior.
      It keeps all devices on comparable scales, provides separate read and write
      latency-density lanes on fixed logarithmic axes, displays mount and backing-device
      topology, filesystem, mdraid, APFS, ZFS vdev, and SMART facts, and on Linux
      embeds eBPF probes to track block latency histograms and VFS activity by process/path.
    '';
    homepage = "https://github.com/jbellis/iodyne";
    license = licenses.mit;
    mainProgram = "iodyne";
    platforms = platforms.linux ++ platforms.darwin;
  };
}
