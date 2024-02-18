#!/bin/sh
test -f FlutterPP.dmg && rm FlutterPP.dmg
create-dmg \
  --volname "FlutterPP Installer" \
  --volicon "./assets/FlutterPP_installer.icns" \
  --background "./assets/dmg_background.png" \
  --window-pos 200 120 \
  --window-size 800 530 \
  --icon-size 130 \
  --text-size 14 \
  --icon "FlutterPP.app" 260 250 \
  --hide-extension "FlutterPP.app" \
  --app-drop-link 540 250 \
  --hdiutil-quiet \
  "build/macos/Build/Products/Release/FlutterPP.dmg" \
  "build/macos/Build/Products/Release/FlutterPP.app"