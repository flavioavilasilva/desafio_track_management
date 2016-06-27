class LoadInputTalks < LoadInput

   LIGHTNING = "lightning"
   EXPRESSION_TIME = /(\s\d{1,2}\min)$/
   EXPRESSION_NUMBERS = /(\d{1,2})/

  def self.create_valid_talks
    avaliable_talks = LoadInputTalks.read_file("lib/files/talks.txt")
    list_talks = Array.new

    avaliable_talks.each do |i|
      t = extract_talk(i)
      if t != false
        list_talks.push(t)
      else
        return false
      end
    end
    list_talks
  end

  private

  def self.extract_talk(t)
    name = extract_name(t)
    tempo = extract_time(t) if name != false

    if (name != false) && (tempo != false)
      return Talk.new(name, tempo, nil, nil)
    end
    return false
  end

  def self.extract_name(talk)
    if EXPRESSION_NUMBERS =~ talk.gsub(EXPRESSION_TIME, "")
      puts "Não é permitido numeros no título da talk :" + talk
      return false
    end

    index = EXPRESSION_TIME =~ talk
    if (index.nil? == true || index < 0) && talk.include?(LIGHTNING) == false
      puts "O formato de tempo deve ser sempre em \"min\" : " + talk
      return false
    end

    if index.nil? == false
      return talk.gsub(EXPRESSION_TIME, "")
    else
      return talk.gsub(LIGHTNING, "")
    end
  end

  def self.extract_time(talk)
    exp = EXPRESSION_TIME
    index = exp =~ talk
    time = 0

    if index.nil? == false
      time = talk[index..(index+5)].delete("min").to_i
    end

    index = talk.index(LIGHTNING)
    if index.nil? == false
      time = 5
    end

    if time.to_i < 5
      puts "Tempo menor que 5min não permitido: " + talk
      return false
    end

    if time == false
      puts "Não foi possível extrair o tempo da talk: " + talk
      return false
    end

    return time
  end
end
