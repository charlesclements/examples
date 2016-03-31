#!/bin/bash
#this is a comment-the first line sets bash as the shell script
defaults write com.apple.finder AppleShowAllFiles TRUE;
killall Finder;
exit;