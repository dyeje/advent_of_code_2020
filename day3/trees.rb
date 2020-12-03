def lets_go(right, down)
  trees = []
  File.readlines('input.txt').each do |line|
    row = []
    line.each_char { |char| row.push(char == '#') }
    trees.push(row)
  end

  x = 0
  y = 0
  count = 0

  loop do
    x = (x + right) % 31
    y += 1
    count += 1 if trees[y][x]
    break if y == trees.length - 1
  end

  count
end

lets_go(1) * lets_go(3) * lets_go(5) * lets_go(7) * lets_go(1) * 
