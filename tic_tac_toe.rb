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
