class LoadInput
  def self.read_file(file_path)
    clear_characters(File.readlines(file_path))
  end

  private

  def self.clear_characters(lines)
    lines.map do |l|
      l.strip.delete("\n")
    end
  end
end
