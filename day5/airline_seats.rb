
def binary_search(seat, high, low)
  mid = (high + low) / 2
  return mid if seat.length == 0
  char = seat.shift
  if ['F', 'L'].include? char
    binary_search(seat, mid, low)
  else
    binary_search(seat, high, mid)
  end
end

def airline_seats
  rows = []
  max = 0

  File.readlines('input.txt').each do |line|
    line = line.strip
    row = binary_search(line[0..6].chars, 128, 0)
    column = binary_search(line[-3..-1].chars, 8, 0)

    value = row * 8 + column
    max = value if value > max

    rows[row] ||= []
    rows[row] << column
    rows[row] = rows[row].sort
  end

  rows.each_with_index do |r, i|
    puts i
    puts r.to_s
  end

  max
end