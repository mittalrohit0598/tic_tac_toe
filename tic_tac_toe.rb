# frozen_string_literal: true

# class Cell
class Cell
  attr_accessor :value
  def initialize(value = '')
    @value = value
  end
end

# class Player
class Player
  attr_reader :name, :color
  def initialize(name, color)
    @name = name
    @color = color
  end
end

# class Board
class Board
  attr_reader :grid
  def initialize(grid = default_grid)
    @grid = grid
  end

  def default_grid
    Array.new(3) { Array.new(3) { Cell.new } }
  end

  def set_value(row, column, value)
    grid(row, column).value = value
  end

  def get_value(row, column)
    grid(row, column)
  end
end
