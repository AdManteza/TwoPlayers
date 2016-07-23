class Player
  attr_accessor :name, :player_lives, :player_points

  def initialize(name)
    @name = name
    @player_lives = 3
    @player_points = 0
  end

  def gain_a_point
    @player_points += 1
  end

  def lose_a_life
    @player_lives -= 1
  end

  #player gives answer, or more accurately, guesses the answer
  def give_answer(clue) 
    case clue

    when "plus"
      rand(1..30)
    when "minus"
      rand(1..20)
    when "multiplied by"
      rand(1..400)
    else 
      rand(1..10)
    end
  end
end

class Question
  @@no_of_questions = 0
  RANDOM_MATH = ['plus', 'minus', 'multiplied by', 'divided by']
  attr_accessor :operation, :num1, :num2

  def initialize
    @operation = RANDOM_MATH.sample # passes a random string from RANDOM_MATH array to @operation
    @num1 = rand(1..20)
    @num2 = rand(1..20)
    @@no_of_questions += 1
  end

  # generates a question
  def generate_a_question
    "What is #{@num1} #{@operation} #{@num2}?"  
  end

  # question answers its own question :)
  def give_correct_answer 
    case @operation
    when "plus"
      @num1.to_i + @num2.to_i
    when "minus"
      @num1.to_i - @num2.to_i
    when "multiplied by"
      @num1.to_i * @num2.to_i
    else 
      @num1.to_i / @num2.to_i
    end
  end

  def self.return_number_of_questions
    @@no_of_questions
  end
end

class Game
  attr_reader :question, :answer, :correct_answer

  def initialize(player1, player2)
    @player1 = Player.new(player1)# game gets the players 
    @player2 = Player.new(player2)# for the game
    @answer = []
  end

  def display_current_players
    "#{@player1.name} is ready to play! \n#{@player2.name} is ready to play!"
  end

  # game asks the question
  def ask_a_question
    @question = Question.new
    @correct_answer = @question.give_correct_answer
    @question.generate_a_question
  end

  def get_players_answer
    @answer[0] = @player1.give_answer(@question.operation)
    @answer[1] = @player2.give_answer(@question.operation)
  end

  def display_players_answer
    "#{@player1.name} answered #{@answer[0]} \n#{@player2.name} answered #{@answer[1]}"
  end

  def evaluate_answer
    @player1.lose_a_life if @answer[0] != @correct_answer
    @player2.lose_a_life if @answer[1] != @correct_answer
    @player1.gain_a_point if @answer[0] == @correct_answer
    @player2.gain_a_point if @answer[1] == @correct_answer
  end

  def display_player_status
    "#{@player1.name} has #{@player1.player_lives} lives left and a score of:#{@player1.player_points} \n#{@player2.name} has #{@player2.player_lives} lives left and a score of:#{@player2.player_points}"
  end

  def announce_result
    if @player1.player_points > @player2.player_points
      puts "#{@player1.name} is better at math than #{@player2.name}"
    elsif @player2.player_points > @player1.player_points
      puts "#{@player2.name} is better at math than #{@player1.name}"
    else
      puts "Both #{@player1.name} and #{@player2.name} suck at Math!!"
    end
  end

  def no_more_lives?
    @player1.player_lives == 0 || @player2.player_lives == 0
  end

  def reset_player_lives
    @player1.player_lives = 3
    @player2.player_lives = 3
  end
end
