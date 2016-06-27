class ControlConference
  attr_accessor :avaliable_talks, :current_session

  def initialize(avaliable_talks, current_session)
    @avaliable_talks = avaliable_talks
    @current_session = current_session
  end
end
