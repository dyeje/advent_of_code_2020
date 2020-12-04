require 'set'

COLOR = /#[a-fA-F0-9]{6}/
PID = /[0-9]{9}/
COLORS = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']

def validate_field(key, value)
  case key
  when 'byr'
    birth_year = value.to_i
    1920 <= birth_year && birth_year <= 2002
  when 'iyr'
    issue_year = value.to_i
    2010 <= issue_year && issue_year <= 2020
  when 'eyr'
    exp_year = value.to_i
    2020 <= exp_year && exp_year <= 2030
  when 'hgt'
    unit = value[-2..-1]
    height = value[0...-2].to_i
    if unit == 'cm'
      150 <= height && height <= 193
    elsif unit == 'in'
      59 <= height && height <= 76
    end
  when 'hcl'
    COLOR.match?(value)
  when 'ecl'
    COLORS.include?(value)
  when 'pid'
    # Why isn't this regex working?
    PID.match?(value) && value.length == 9
  when 'cid'
    true
  end
end

def validate_passports
  valid_count = 0
  current_passport = {}

  File.readlines('input.txt').each do |line|
    if line.strip.empty?
      keys = Set.new(current_passport.keys)
      
      if (keys.length == 8 || (keys.length == 7 && !keys.include?('cid')))
        if current_passport.all? { |k, v| validate_field(k, v) } 
          current_passport['cid'] = 'xxx'
          current_passport['hgt'] = 'xxx'
          puts current_passport.sort.to_h
          valid_count += 1
        end
      end
  
      current_passport = {}
    else
      line.split(' ').each do |field| 
        split = field.split(':')
        current_passport[split[0]] = split[1]
      end
    end
  end

  valid_count
end