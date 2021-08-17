#!/usr/bin/env ruby -wKU

###################################################################
# build Soundflower, install it, and start it
# installs to /Library/Extensions
# requires admin permissions and will ask for your password
###################################################################

#require 'open3'
require 'fileutils'
require 'pathname'
#require 'rexml/document'
#include REXML

# This finds our current directory, to generate an absolute path for the require
libdir = "."
Dir.chdir libdir        # change to libdir so that requires work

@prj_root = ".."

puts "  Unloading and removing existing Soundflower.kext"
if File.exists?("/Library/Extensions/Soundflower.kext")
  puts "    first unload (will often fail, but will cause Soundflower's performAudioEngineStop to be called)"
  `sudo kextunload /Library/Extensions/Soundflower.kext`
  puts "    second unload (this one should work)"
  `sudo kextunload /Library/Extensions/Soundflower.kext`
  puts "    removing"
  puts `sudo rm -rf /Library/Extensions/Soundflower.kext`
end

puts "  Copying to /Library/Extensions and loading kext"
`sudo cp -rv "#{@prj_root}/Build/Soundflower.kext" /Library/Extensions`
`sudo kextload -tv /Library/Extensions/Soundflower.kext`
`sudo touch /Library/Extensions`

puts "  Done."
puts ""
exit 0
