def surveys
  sum = 0
  current_group = {}
  File.readlines('input.txt').each do |line|
    line = line.strip
    if line.empty?
      sum += current_group.keys.length
      current_group = {}
    else
      line.each_char { |char| current_group[char] = true }
    end
  end

  sum
end

def surveys_2
  sum = 0
  current_group = []
  File.readlines('input.txt').each do |line|
    line = line.strip
    if line.empty?
      answers = current_group.flat_map { |person| person.keys }.uniq
      puts answers
      sum += answers.map { |a| current_group.all? { |person| person[a] } || nil }.compact.length
      current_group = []
    else
      person = {}
      line.each_char { |char| person[char] = true }
      current_group << person
    end
  end

  sum
end
