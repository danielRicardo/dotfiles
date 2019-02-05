#!/bin/bash

# set screeshots default folder
mkdir -p ~/Pictures/screenshots
defaults write com.apple.screencapture location ~/Pictures/screenshots && killall SystemUIServer

# enable key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Show Library folder
chflags nohidden ~/Library

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
