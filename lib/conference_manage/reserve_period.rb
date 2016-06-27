class ReservePeriod < Talk

  def self.reserve_period(talk_list, session)
    if session.name.downcase == "morning"
      talk_list.push(ReservePeriod.new("Lunch", 60, "12:00", "13:00"))
    end

    if session.name.downcase == "afternoon"
      split_time = talk_list.last.end_time.to_s.split(":")
      start_time = Time.new("01","01","01", split_time[0].to_i, split_time[1].to_i)
      if start_time >= Time.new("01","01","01", 16,00)
        talk_list.push(ReservePeriod.new("Network", nil,
                        start_time.strftime("%T"), nil))
      else
        talk_list.push(ReservePeriod.new("Network", nil,
                        "16:00", nil))
      end
    end
    talk_list
  end
end
