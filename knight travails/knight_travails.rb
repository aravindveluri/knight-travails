def get_valid_input
  input = gets.chomp
  begin
    raise if !((0..7) === Integer(input))
    return Integer input
  rescue
    puts "Please enter a number from 0 to 7(both inclusive)"
    input = gets.chomp
    retry
  end
end

def get_coordinate
  [get_valid_input, get_valid_input]
end

def get_valid_moves(coordinate)
  [-2, -1, 1, 2].product([-2, -1, 1, 2]).select { 
    |x, y| x.abs != y.abs 
  }
  .select { |delta_x, delta_y|
    [coordinate[0] + delta_x, coordinate[1] + delta_y].all?{ 
      |c| (0..7) === c 
    }
  }
end

def get_path(parent_of, final_pos)
  path = []
  path.push final_pos
  current_pos = final_pos
  while parent_of[current_pos] != current_pos
    current_pos = parent_of[current_pos]
    path.unshift current_pos
  end
  return path
end

def print_path(path) 
  puts "You've travelled in #{path.length-1} steps. The path is "
  path.each {|coordinate| p coordinate}
end

def knight_moves(initial_pos, final_pos)
  queue = []
  queue.push initial_pos
 
  parent_of = Hash.new
  parent_of[initial_pos] = initial_pos

  flag = false
  
  while !queue.empty? && !flag
    current_pos = queue.shift
    
    get_valid_moves(current_pos).collect {
      |delta_x, delta_y| [current_pos[0] + delta_x, current_pos[1] + delta_y]
    }
    .each { |possible_coordinate|
      if possible_coordinate == final_pos
        parent_of[final_pos] = current_pos
        flag = true
        break
      elsif parent_of[possible_coordinate].nil?
        parent_of[possible_coordinate] = current_pos
        queue.push possible_coordinate
      end
    }
  end
  print_path get_path parent_of, final_pos
end

knight_moves get_coordinate, get_coordinate