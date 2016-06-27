require './lib/conference_manage/talk.rb'
require './lib/conference_manage/reserve_period.rb'

class Session

  attr_accessor :name, :duration_time, :start_time, :end_time, :talk_list

  def initialize(name, duration_time, start_time, end_time, talk_list)
    @name = name
    @duration_time = duration_time
    @start_time = start_time
    @end_time = end_time
    @talk_list = talk_list
  end

  def self.create_list_session(control_conference)
    sessions = Array.new
    session_list = Array.new
    session_list.push (self.new("Morning",180,"09:00","12:00", nil))
    session_list.push (self.new("Afternoon",240,"13:00","17:00", nil))

    session_list.each do |s|
      if control_conference.avaliable_talks.size > 0
        control_conference.current_session = s.dup
        s.talk_list = Talk.manage_talks(control_conference.avaliable_talks,
                                control_conference.current_session)
        sessions.push(s)
      end
    end
    sessions
  end

  def self.retire_time_session(current_session, talk)
    current_session.duration_time -= talk.duration_time
    current_session
  end

  def self.total_time(session_list)
    total_time = 0
    session_list.each do |s|
      total_time += s.duration_time.to_i
    end
    total_time
  end
end
