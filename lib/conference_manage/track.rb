require './lib/conference_manage/session.rb'
require './lib/conference_manage/control_conference.rb'
require './lib/conference_manage/load_input.rb'
require './lib/conference_manage/load_input_talks.rb'

class Track
  attr_accessor :name, :date_track, :session_list

  def initialize(name, date_track, session_list)
    @name = name
    @date_track = date_track
    @session_list = session_list
  end

  def self.create_track
    cont_track = 1
    valid_avaliable_talks = LoadInputTalks.create_valid_talks

    if valid_avaliable_talks
      track_list = Array.new
      control_conference = ControlConference.new(valid_avaliable_talks, nil)
      while (control_conference.avaliable_talks.size > 1) do
        track = self.new("Track " + cont_track.to_s, Time.new, nil)
        track.session_list = Session.create_list_session(
                                      control_conference)
        track_list.push(track)
        cont_track += 1
      end
    end
    track_list
  end
end
