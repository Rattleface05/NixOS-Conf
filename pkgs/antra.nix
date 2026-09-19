{ appimageTools, fetchurl }:
let
  pname = "Antra";
  version = "1.1.8";

  src = fetchurl {
    url = "https://github.com/anandprtp/Antra/releases/download/v${version}/Antra-Linux.AppImage";
    hash = "sha256-g+x5ap/6nqdeVccdV1kz3kBg9y6fbplXIp+uBr75790=";
  };
  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;
  extraPkgs = pkgs: [
    pkgs.webkitgtk_4_1
    pkgs.libsoup_3
  ];
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/Antra.desktop $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-warn "Exec=AppRun" "Exec=${pname}"

    install -m 444 -D ${appimageContents}/Antra.png $out/share/icons/hicolor/512x512/apps/${pname}.png
  '';
  meta.mainProgram = "Antra";
}
