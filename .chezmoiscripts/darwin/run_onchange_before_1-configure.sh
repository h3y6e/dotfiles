#!/bin/bash

set -Eeufo pipefail

# https://macos-defaults.com
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

printf "\033[3;35m%s\033[m\n" "setting up configure..."

# Dockを自動的に表示/非表示
defaults write com.apple.dock autohide -bool true
# リピート入力認識までの時間: 最短
defaults write -g InitialKeyRepeat -int 15
# キーのリピート: 最速
defaults write -g KeyRepeat -int 2
# キー長押しによる連続入力
defaults write -g ApplePressAndHoldEnabled -bool false
# 外部キーボードのF1, F2などのキーを標準のファンクションキーとして使用
defaults write -g com.apple.keyboard.fnState -bool true
# キーボードショートカット > 次のウィンドウを操作対象にする: オフ (ブラウザのcmd+2と干渉する為)
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 "{enabled=0;value={parameters=(64,33,1048576);type='standard';};}"
# キーボードショートカット > Spotlight検索を表示: オフ
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{enabled=0;value={parameters=(65535,49,1048576);type='standard';};}"
# トラックパッド > クリック: 弱い
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
# トラックパッド > 軌跡の速さ: 真ん中
defaults write -g com.apple.trackpad.scaling -float 1
# ユーザインターフェイスのサウンドエフェクトを再生: オフ
defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -bool false
# 音量を変更する時にフィードバックを再生: オン
defaults write -g com.apple.sound.beep.feedback -bool true
# デスクトップ項目: オン
defaults write com.apple.finder CreateDesktop -bool true
# 時計: 24時間表示
defaults write com.apple.menuextra.clock Show24Hour -int 1
# 時計: 日付を非表示
defaults write com.apple.menuextra.clock ShowDate -int 2
# 時計: 曜日を非表示
defaults write com.apple.menuextra.clock ShowDayOfWeek -int 0
# 時計: 秒を表示
defaults write com.apple.menuextra.clock ShowSeconds -int 1
# コントロールセンター > メニューバーにVPNの状態を表示: オン
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.vpn" -bool true
