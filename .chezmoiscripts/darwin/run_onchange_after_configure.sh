#!/bin/bash

set -Eeufo pipefail

# https://macos-defaults.com
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# Dockを自動的に表示/非表示
defaults write com.apple.dock autohide -bool true
# リピート入力認識までの時間: 最短
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# キーのリピート: 最速
defaults write NSGlobalDomain KeyRepeat -int 2
# キー長押しによる連続入力
defaults write -g ApplePressAndHoldEnabled -bool false
# トラックパッド > クリック: 弱い
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
# トラックパッド > 軌跡の速さ: 真ん中
defaults write 'Apple Global Domain' com.apple.trackpad.scaling -float 1
