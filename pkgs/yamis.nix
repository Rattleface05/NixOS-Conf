{ stdenvNoCC, fetchurl }:
let
  pname = "yet-another-monochrome-icon-set";
  version = "367da5d"; # or use a commit hash / date

  src = fetchurl {
    url = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set/get/${version}.tar.gz";
    # Replace this hash with the correct one after your first build attempt
    # (or use sha256-0000000000000000000000000000000000000000000= to let Nix fail and tell you the right one)
    sha256 = "sha256-00sr668jGCC4QNBg+sqI+40MA0EqK/ZCYeTwB7OEPcE=";
  };
in
stdenvNoCC.mkDerivation {
  inherit pname version src;
  # Bitbucket tarballs contain a root folder with a random hash name,
  # so we unpack and tell Nix to strip it cleanly or handle it via unpackPhase.
  # Usually, Bitbucket's tarball extracts into a directory like `dirn-typo-yet-another-monochrome-icon-set-<hash>`
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    # Create the proper icon directory structure in the Nix store output ($out)
    # Typically icon themes live in $out/share/icons/<theme-name>
    # Note: Check the folder name inside the extracted repo (e.g., if it extracts to yet-another-monochrome-icon-set or similar)

    mkdir -p $out/share/icons/YAMIS

    # Copy contents into the icon directory. 
    # Adjust path if the source files are nested inside an intermediate folder.
    cp -r dirn-typo-yet-another-monochrome-icon-set-*/* $out/share/icons/YAMIS/

    runHook postInstall
  '';

  meta = {
    description = "A monochrome adaptive icon theme for KDE Plasma and desktop environments";
    homepage = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set";
    platforms = [
      "any"
      "x86_64-linux"
    ];
  };
}
