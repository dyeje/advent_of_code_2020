LEFT_90 = {
  'N' => 'W',
  'W' => 'S',
  'S' => 'E',
  'E' => 'N'
}

RIGHT_90 = {
  'N' => 'E',
  'E' => 'S',
  'S' => 'W',
  'W' => 'N'
}

LR_180 = {
  'N' => 'S',
  'E' => 'W',
  'S' => 'N',
  'W' => 'E'
}

LEFT_270 = RIGHT_90
RIGHT_270 = LEFT_90

def mandis
  heading = 'E'
  ns_total = 0
  ew_total = 0
  File.readlines('input.txt').each do |line|
    line = line.chomp
    instruction = line[0]
    # puts "#{line} #{heading}"
    value = line[1..-1].to_i

    instruction = heading if instruction == 'F'

    if instruction == 'N'
      ns_total += value
    elsif instruction == 'S'
      ns_total -= value
    elsif instruction == 'E'
      ew_total += value
    elsif instruction == 'W'
      ew_total -= value
    elsif instruction == 'R'
      puts line
      puts heading
      case value
      when 90
        heading = RIGHT_90[heading]
      when 180
        heading = LR_180[heading]
      when 270
        heading = RIGHT_270[heading]
      end
      puts heading
      puts ''
    elsif instruction == 'L'
      puts line
      puts heading
      case value
      when 90
        heading = LEFT_90[heading]
      when 180
        heading = LR_180[heading]
      when 270
        heading = LEFT_270[heading]
      end
      puts heading
      puts ''
    end
  end

  ns_total.abs + ew_total.abs
end

def mandis2
  ns_total = 0
  ew_total = 0
  heading1 = 'E'
  waypoint1 = 10
  heading2 = 'N'
  waypoint2 = 1
  File.readlines('input.txt').each do |line|
    line = line.chomp
    instruction = line[0]
    value = line[1..-1].to_i

    puts "#{line} #{instruction} #{value}"

    if instruction == 'F'
      [{ h: heading1, v: waypoint1 }, { h: heading2, v: waypoint2 }].each do |thing|
        yeah = thing[:v] * value
        if thing[:h] == 'N'
          ns_total += yeah
        elsif thing[:h] == 'S'
          ns_total -= yeah
        elsif thing[:h] == 'E'
          ew_total += yeah
        elsif thing[:h] == 'W'
          ew_total -= yeah
        end
      end

      next
    end

    if instruction == 'N'
      if heading1 == 'N'
        waypoint1 += value
      elsif heading1 == 'S'
        waypoint1 -= value
      end

      if heading2 == 'N'
        waypoint2 += value
      elsif heading2 == 'S'
        waypoint2 -= value
      end
    elsif instruction == 'S'
      if heading1 == 'N'
        waypoint1 -= value
      elsif heading1 == 'S'
        waypoint1 += value
      end

      if heading2 == 'N'
        waypoint2 -= value
      elsif heading2 == 'S'
        waypoint2 += value
      end
    elsif instruction == 'E'
      if heading1 == 'E'
        waypoint1 += value
      elsif heading1 == 'W'
        waypoint1 -= value
      end

      if heading2 == 'E'
        waypoint2 += value
      elsif heading2 == 'W'
        waypoint2 -= value
      end
    elsif instruction == 'W'
      if heading1 == 'E'
        waypoint1 -= value
      elsif heading1 == 'W'
        waypoint1 += value
      end

      if heading2 == 'E'
        waypoint2 -= value
      elsif heading2 == 'W'
        waypoint2 += value
      end
    end

    if instruction == 'R'
      # puts line
      # puts heading
      case value
      when 90
        heading1 = RIGHT_90[heading1]
        heading2 = RIGHT_90[heading2]
      when 180
        heading1 = LR_180[heading1]
        heading2 = LR_180[heading2]
      when 270
        heading1 = RIGHT_270[heading1]
        heading2 = RIGHT_270[heading2]
      end
      # puts heading
      # puts ''
    elsif instruction == 'L'
      # puts line
      # puts heading
      case value
      when 90
        heading1 = LEFT_90[heading1]
        heading2 = LEFT_90[heading2]
      when 180
        heading1 = LR_180[heading1]
        heading2 = LR_180[heading2]
      when 270
        heading1 = LEFT_270[heading1]
        heading2 = LEFT_270[heading2]
      end
      # puts heading
      # puts ''
    end
    puts "#{ns_total} #{ew_total} #{heading1} #{waypoint1} #{heading2} #{waypoint2}"
    puts ''
  end

  ns_total.abs + ew_total.abs
end