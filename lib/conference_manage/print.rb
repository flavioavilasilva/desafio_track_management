class Print

  def self.print_conference(track_list)
    track_list.each do |track|
      puts "\n\n"
      puts track.name
      puts "-------\n\n"
      track.session_list.each do |s|
        s.talk_list.each do |talk|
          puts talk.start_time + " " + talk.name
        end
      end
    end
  end

end
