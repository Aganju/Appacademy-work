require 'byebug'
class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    if require_sequence
      round_success_message
      @sequence_length += 1
    else
      @game_over = true
    end
  end

  def show_sequence
    add_random_color
    puts seq
    # sleep(1.5)
    # system('clear')
  end

  def require_sequence
    puts 'enter the colors in the same order'
    seq.length.times do |seq_pos|
      puts "color #{seq_pos + 1}:"
      return false unless gets.chomp == seq[seq_pos]
    end
    true
  end

  def add_random_color
    seq << COLORS[rand(4)]
  end

  def round_success_message
    puts 'Well done! You got it right!'
  end

  def game_over_message
    puts 'Sorry, you failed'
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
