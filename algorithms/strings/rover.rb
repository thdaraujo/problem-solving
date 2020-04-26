# frozen_string_literal: true

class Rover
  attr_reader :current_position, :current_direction

  def initialize(initial_position, initial_direction)
    @current_position = initial_position
    @current_direction = initial_direction
  end

  def send_instructions(instructions)
    instructions.chars.each do |instruction|
      handle_instruction(instruction)
    end
  end

  def position
    @current_position
  end

  def direction
    @current_direction
  end

  private

  def handle_instruction(instruction)
    if %w[l r].include?(instruction)
      change_direction!(instruction)
    elsif %w[f b].include? instruction
      move!(instruction)
    end
  end

  def change_direction!(instruction)
    rotation = {
      north: { 'l' => :west, 'r' => :east },
      west: { 'l' => :south, 'r' => :south },
      south: { 'l' => :east, 'r' => :west },
      east: { 'l' => :north, 'r' => :south }
    }

    new_direction = rotation[direction][instruction]
    @current_direction = new_direction
  end

  def move!(instruction)
    dx, dy = instruction_to_delta(instruction)
    @current_position[0] += dx
    @current_position[1] += dy
  end

  def instruction_to_delta(instruction)
    delta = instruction == 'f' ? 1 : -1
    dx = 0
    dy = 0

    case direction
    when :north
      dy = delta
    when :south
      dy = -delta
    when :west
      dx = -delta
    when :east
      dx = delta
    end

    [dx, dy]
  end
end

require 'test/unit/assertions'
include Test::Unit::Assertions

def test_case_1
  rover = Rover.new([0, 0], :north)
  rover.send_instructions('lffflbbb')

  assert_equal(rover.position, [-3, 3])
  assert_equal(rover.direction, :south)

  rover.send_instructions('fff')
  assert_equal(rover.position, [-3, 0])
  assert_equal(rover.direction, :south)
end

def test_case_2
  rover = Rover.new([3, 4], :east)
  rover.send_instructions('fffrfbrflb')

  assert_equal(rover.position, [5, 5])
  assert_equal(rover.direction, :south)
end

def test_case_3
  rover = Rover.new([-5, 22], :south)
  rover.send_instructions('lrffbb')

  assert_equal(rover.position, [-5, 22])
  assert_equal(rover.direction, :south)
end

test_case_1
test_case_2
test_case_3
