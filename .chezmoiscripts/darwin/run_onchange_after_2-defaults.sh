#!/bin/bash
# macOS defaults unsupported by mise's [bootstrap.macos.defaults]
# (delete, dict values, sudo system domains):
# https://mise.jdx.dev/bootstrap/macos-defaults.html

set -Eeufo pipefail

printf "\033[3;35m%s\033[m\n" "setting up configure..."

# remove all app shortcuts from the Dock
defaults delete com.apple.dock persistent-apps 2>/dev/null || true
# disable the "Show Spotlight search" keyboard shortcuts
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 '<dict><key>enabled</key><false/></dict>'
# hide the input source switch indicator
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool NO
# relaunch to pick up changed defaults
killall Dock Finder SystemUIServer || true
