def acc_before_loop
  instructions = []
  hits = []
  acc = 0
  current_pointer = 0

  File.readlines('input.txt').each do |line|
    line = line.strip.split(' ')
    instructions << { op: line[0], value: line[1].to_i }
  end

  loop do
    return acc if hits.include? current_pointer
    hits << current_pointer
    instruction = instructions[current_pointer]
    puts({ cp: current_pointer, acc: acc, instruction: instruction })
    if instruction[:op] == 'nop'
      current_pointer += 1
    elsif instruction[:op] == 'acc'
      acc += instruction[:value]
      current_pointer += 1
    elsif instruction[:op] == 'jmp'
      current_pointer += instruction[:value]
    end
  end
end

def correct_final_acc
  instructions = []
  hits = []
  acc = 0
  cp = 0 # current pointer
  cc = 0 # current corruption

  File.readlines('input.txt').each do |line|
    line = line.strip.split(' ')
    instructions << { op: line[0], value: line[1].to_i }
  end

  loop do
    # Correupt or move on
    if instructions[cc][:op] == 'jmp'
      instructions[cc][:op] = 'nop'
    elsif instructions[cc][:op] == 'nop'
      instructions[cc][:op] = 'jmp'
    else
      cc += 1
      next
    end

    loop do
      # There's a loop, reset
      if hits.include? cp
        hits = []
        cp = 0
        acc = 0
        break
      end
      # Answer found
      return acc if instructions[cp].nil?

      hits << cp
      instruction = instructions[cp]
      puts({ cp: cp, acc: acc, instruction: instruction })
      if instruction[:op] == 'nop'
        cp += 1
      elsif instruction[:op] == 'acc'
        acc += instruction[:value]
        cp += 1
      elsif instruction[:op] == 'jmp'
        cp += instruction[:value]
      end
    end

    # Uncorrupt
    if instructions[cc][:op] == 'jmp'
      instructions[cc][:op] = 'nop'
    elsif instructions[cc][:op] == 'nop'
      instructions[cc][:op] = 'jmp'
    end

    cc += 1
  end
end