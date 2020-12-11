def joltage
  numbers = []
  File.readlines('input.txt').each do |line|
    number = line.strip.to_i
    numbers << number
  end

  numbers.sort!
  one_diff = 0
  three_diff = 1
  prev_number = 0
  numbers.each_with_index do |n, i|
    if i > 0
      prev_number = numbers[i - 1]
    end

    puts [prev_number, n].to_s
    if (n - prev_number) == 1
      one_diff += 1
    elsif (n - prev_number) == 3
      three_diff += 1
    end
  end

  one_diff * three_diff
end

# Credit to github.com/pseale, I was not able to figure this out on my own
TRIBONACCI = [1, 1, 2, 4, 7, 13, 24, 44, 81, 149]
def valid_adapter_combos
  numbers = []
  File.readlines('input.txt').each do |line|
    number = line.strip.to_i
    numbers << number
  end

  numbers.sort!
  numbers.unshift(0)
  numbers.push(numbers.last + 3)

  multiplier = 1
  current_run = 1
  numbers.each do |n|
    if numbers.include?(n + 1)
      current_run += 1
    else
      multiplier *= TRIBONACCI[current_run - 1]
      current_run = 1
    end
  end

  multiplier
end