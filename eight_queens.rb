
class Chess
    attr_accessor :grid, :which_row, :queens_placed
    attr_reader :max_i 
    
    def initialize(size)
        @grid = Array.new(size) {Array.new(size, ".")}
        @max_i = size - 1
        @which_row = (0..(size - 1)).to_a
        @queens_placed = 0
    end

    def print_grid
        grid.each do |row|
            row.each {|space| print space + " "}
            puts
        end
        puts
    end

    def solve
        grid.each_with_index do |row, y|
            row.each_with_index do |space, x|
                self.place_queen(y, x)
            end
        end
        grid.each_with_index do |row, y|
            row.each_with_index do |space, x|
                @queens_placed += 1 if space == "Q"
            end
        end
        if @queens_placed != (max_i + 1)
            @queens_placed = 0
            grid.each_with_index do |row, y|
                row.each_with_index do |space, x|
                    this_row = rand(0..max_i)
                    if space == "Q" && y == which_row[this_row]
                        grid[y][x] = "X"
                        grid.each_with_index do |row, y|
                            row.each_with_index do |space, x|
                                self.place_queen(y, x)
                            end
                        end
                        grid[y][x] = "."
                    end
                end
            end
            self.solve
        end
    end
    
    def place_queen(y, x)
        grid[y][x] = "Q" if self.valid?(y, x)
    end

    def valid?(y, x)
        return false if grid[y][x] == "Q" || grid[y][x] == "X"
        grid.each_with_index do |row, other_y|
            row.each_with_index do |space, other_x|
                if space == "Q"
                    return false if other_y == y || other_x == x
                    mod_y = 1
                    mod_x = 1
                    while (other_y + mod_y <= max_i ) && (other_x - mod_x >= 0)
                        return false if (other_y + mod_y == y) && (other_x - mod_x == x)
                        mod_x += 1
                        mod_y += 1
                    end
                    mod_y = 1
                    mod_x = 1
                    while (other_y - mod_y >= 0 ) && (other_x + mod_x <= max_i)
                        return false if (other_y - mod_y == y) && (other_x + mod_x == x)
                        mod_x += 1
                        mod_y += 1                    
                    end
                    mod_y = 1
                    mod_x = 1
                    while (other_y + mod_y <= max_i ) && (other_x + mod_x <= max_i)
                        return false if (other_y + mod_y == y) && (other_x + mod_x == x)
                        mod_x += 1
                        mod_y += 1                   
                    end
                    mod_y = 1
                    mod_x = 1
                    while (other_y - mod_y >= 0 ) && (other_x - mod_x >= 0)
                        return false if (other_y - mod_y == y) && (other_x - mod_x == x)
                        mod_x += 1
                        mod_y += 1
                    end
                    mod_y = 1
                    mod_x = 1
                end
            end
        end

        true 
    end
end

a = Chess.new(8)
a.solve
a.print_grid