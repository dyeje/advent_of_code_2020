def can_contain_shiny_gold(next_color, map)
  puts next_color
  if map[next_color].empty?
    return false
  elsif map[next_color].include?('shiny gold')
    return true
  else
    return map[next_color].any? { |next_next_color| can_contain_shiny_gold(next_next_color, map) }
  end
end

def bags_1
  map = { }

  File.readlines('input.txt').each do |line|
    line = line.strip
    split = line.split('bags contain')
    type = split[0].strip
    if type == 'shiny gold'
      map[type] = []
      next
    end
    contents = split[1].strip

    if contents.include? 'no other bags'
      map[type] = []
    else
      contents = contents.split(', ').map { |c| c[2..-1].gsub('bags', '').gsub('bag', '').gsub('.', '').strip }
      map[type] = contents
    end
  end

  count = 0
  # pp map
  map.keys.each do |key|
    next if key == 'shiny gold'
    count += 1 if can_contain_shiny_gold(key, map)
  end
  count
end

def total_bags(color, map)
  if map[color].empty?
    return 0
  else
    return map[color].map do |idk|
      idk[:count] + (idk[:count] * total_bags(idk[:type], map))
    end.inject(0){|sum,x| sum + x }
  end
end

def bags_2
  map = {}

  File.readlines('input.txt').each do |line|
    line = line.strip
    split = line.split('bags contain')
    type = split[0].strip
    contents = split[1].strip

    if contents.include? 'no other bags'
      map[type] = []
    else
      contents = contents.split(', ').map { |c| { count: c[0].to_i, type: c[2..-1].gsub('bags', '').gsub('bag', '').gsub('.', '').strip } }
      map[type] = contents
    end
  end

  total_bags('shiny gold', map)
end