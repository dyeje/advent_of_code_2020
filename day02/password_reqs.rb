def check_password_reqs()
  valid_count = 0
  File.readlines('input.txt').each do |line|
    split = line.split(' ')
    requirements = split[0].split('-')

    lower = requirements[0].to_i
    upper = requirements[1].to_i
    letter = split[1][0]
    password = split[2]
    # Could optimize with an early exit, but count is so much prettier
    count = password.count(letter)
    valid_count += 1 if (count >= lower && count <= upper)
  end
  valid_count
end

def check_password_reqs_2()
  valid_count = 0
  File.readlines('input.txt').each do |line|
    split = line.split(' ')
    requirements = split[0].split('-')
    first_position = requirements[0].to_i - 1
    second_position = requirements[1].to_i - 1
    letter = split[1][0]
    password = split[2]
    valid_count += 1 if ((password[first_position] == letter) ^ (password[second_position] == letter))
  end
  valid_count
end