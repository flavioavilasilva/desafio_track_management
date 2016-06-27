#require "conference_manage/version"
require './lib/conference_manage/track.rb'
require './lib/conference_manage/print.rb'

# class Main
#   def initialize()
conference = Track.create_track
Print.print_conference(conference) if conference
#   end
# end
