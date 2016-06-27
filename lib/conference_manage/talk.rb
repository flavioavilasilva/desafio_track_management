class Talk

  attr_accessor :name, :duration_time, :start_time, :end_time

  def initialize(name, duration_time, start_time, end_time)
    @name = name
    @duration_time = duration_time
    @start_time = start_time
    @end_time = end_time
  end

  def self.manage_talks(avaliable_talks, current_session)
    current_avaliable_talks = avaliable_talks.dup
    talk_list = []
    start_time = 0
    end_time = 0

    current_avaliable_talks.each do |t|

      if t.duration_time.to_i <= current_session.duration_time.to_i
        if start_time == 0
          start_time = Time.new("01","01","01", current_session.start_time.to_s)
        else
          start_time = end_time
        end
        t.start_time = start_time.strftime("%T")
        Session.retire_time_session(current_session, t)
        end_time = start_time + (t.duration_time.to_i * 60)
        t.end_time = end_time.strftime("%T")
        talk_list.push(t)
        avaliable_talks.delete(t)
      else
        return define_reserve_time(talk_list, current_session)
      end
    end
    define_reserve_time(talk_list, current_session)
  end

  private

  def self.define_reserve_time(talk_list, session)
    ReservePeriod.reserve_period(talk_list, session)
  end
end
