def xmas_weak
  numbers = []
  current_index = 0
  File.readlines('input.txt').each do |line|
    number = line.strip.to_i
    numbers << number

    if current_index > 25
      prev_25 = numbers[(current_index - 26)...current_index]
      return number unless prev_25.combination(2).to_a.any? do |nums|
        number == (nums[0] + nums[1])
      end
    end

    current_index += 1
  end

  false
end

def xmas_answer(weak_number)
  numbers = []
  lower = 0
  upper = 0

  File.readlines('input.txt').each do |line|
    number = line.strip.to_i
    numbers << number
  end

  loop do
    sum = numbers[lower..upper].sum
    if sum > weak_number
      lower += 1
    elsif sum < weak_number
      upper += 1
    else
      return numbers[lower..upper].min + numbers[lower..upper].max
    end
  end
end