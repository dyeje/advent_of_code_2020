BUSES_CONTEST = [41,'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 37,'x', 'x', 'x', 'x', 'x', 431,'x', 'x', 'x', 'x', 'x', 'x', 'x', 23,'x', 'x', 'x', 'x', 13,'x', 'x', 'x', 17,'x', 19,'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 863,'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 29]
BUSES = [41, 37, 431, 23, 13, 17, 19, 863, 29].sort
EXAMPLE = [7,13,'x', 'x', 59,'x', 31,19]


def thebus1(timestamp, buses)
  winner = 0
  least_wait_time = 1000000000
  buses.each do |bus|
    wait_time = ((timestamp.to_f / bus).ceil * bus) - timestamp
    puts "this bus: #{bus} #{wait_time} \nwinner bus: #{winner} #{least_wait_time}"
    puts ''
    if wait_time < least_wait_time
      winner = bus
      least_wait_time = wait_time
    end
  end

  winner * least_wait_time
end

def thebus2(input_buses, min)
  buses = []
  input_buses.each_with_index do |bus, i|
    next if bus == 'x'
    buses << { n: bus, offset: i }
  end
  b1 = buses.shift
  start = (min / b1[:n]).ceil * b1[:n]

  loop do
    puts start
    yas = true

    buses.each do |bus|
      yas = (start + bus[:offset]) % bus[:n] == 0
      break unless yas
    end

    return start if yas
    start = start + b1[:n]
  end
end
