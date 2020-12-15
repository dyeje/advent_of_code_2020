def maskin
  mem = {}
  mask = nil

  File.readlines('input.txt').each do |line|
    line = line.chomp

    if line.start_with?('mask')
      split = line.split(' = ')
      mask = split[1]
    else
      split = line.split(' = ')
      key = split[0].gsub('mem[', '').gsub(']', '').to_i
      value = split[1].to_i

      value = value.to_s(2)
      diff = mask.length - value.length
      diff.times { value = '0' + value }

      mask.chars.each_with_index do |c, i|
        next if c == 'X'
        value[i] = c
      end

      mem[key] = value.to_i(2)
    end
  end

  mem.values.sum
end

def all_addr(addr)
  x_count = addr.count('X')
  combos = 2 ** addr.count('X')

  (0...combos).map do |x|
    new_addr = addr.clone

    bit_x = x.to_s(2)
    (x_count - bit_x.length).times { bit_x = '0' + bit_x }

    bit_x.chars.each { |bit| new_addr.sub!('X', bit) }
    new_addr.to_i(2)
  end
end

def maskin2_elec_bugaloo
  mem = {}
  mask = nil

  File.readlines('input.txt').each do |line|
    line = line.chomp
    if line.start_with?('mask')
      split = line.split(' = ')
      mask = split[1]
    else
      split = line.split(' = ')
      key = split[0].gsub('mem[', '').gsub(']', '').to_i
      value = split[1].to_i

      key = key.to_s(2)
      diff = mask.length - key.length
      diff.times { key = '0' + key }

      mask.chars.each_with_index do |c, i|
        next if c == '0'
        key[i] = c
      end

      all_addr(key).each { |addr| mem[addr] = value }
    end
  end

  mem.values.sum
end