EMPTY = 'L'
OCCUPIED = '#'
NOTHING = '.'

def calc_dir(x, y, direction, board, recurse)
  case direction
  when 'north'
    next_x = x
    next_y = y - 1
  when 'northeast'
    next_x = x + 1
    next_y = y - 1
  when 'northwest'
    next_x = x - 1
    next_y = y - 1
  when 'east'
    next_x = x + 1
    next_y = y
  when 'west'
    next_x = x - 1
    next_y = y
  when 'southeast'
    next_x = x + 1
    next_y = y + 1
  when 'southwest'
    next_x = x - 1
    next_y = y + 1
  when 'south'
    next_x = x
    next_y = y + 1
  end

  if (0...board.length).include?(next_x) && (0...board[0].length).include?(next_y)
    next_seat = board[next_x][next_y]
    return false if next_seat == EMPTY
    return true if next_seat == OCCUPIED
    if next_seat == NOTHING && recurse
      return calc_dir(next_x, next_y, direction, board, recurse)
    else
      false
    end
  else
    false
  end
end

def gol(recurse, threshold)
  board = []
  File.readlines('input.txt').each do |line|
    row = line.chomp.chars
    board << row
  end

  new_board = board.clone.map(&:clone)
  loop do
    board = new_board.clone.map(&:clone)
    changed = false
    occupied = 0

    board.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        next if cell == NOTHING
        occupied += 1 if cell == OCCUPIED

        adj_occ = 0
        adj_occ += 1 if calc_dir(x, y, 'north', board, recurse)
        adj_occ += 1 if calc_dir(x, y, 'northeast', board, recurse)
        adj_occ += 1 if calc_dir(x, y, 'northwest', board, recurse)
        adj_occ += 1 if calc_dir(x, y, 'east', board, recurse)
        adj_occ += 1 if calc_dir(x, y, 'west', board, recurse)
        adj_occ += 1 if calc_dir(x, y, 'southeast', board, recurse)
        adj_occ += 1 if calc_dir(x, y, 'southwest', board, recurse)
        adj_occ += 1 if calc_dir(x, y, 'south', board, recurse)

        if cell == EMPTY && adj_occ == 0
          new_board[x][y] = OCCUPIED
          changed = true
        end
        if cell == OCCUPIED && adj_occ >= threshold
          new_board[x][y] = EMPTY
          changed = true
        end
      end
    end

    return occupied if !changed
  end
end