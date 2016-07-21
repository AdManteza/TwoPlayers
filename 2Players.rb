@Player1_lives = 3
@Player2_lives = 3

def display_score
  p "Player1 available lives: #{@Player1_lives}"
  p "Player2 available lives: #{@Player2_lives}"
end

def generate_number
  @num1 = rand(1..20)
  @num2 = rand(1..20)
end

def verify_answer?
  @expected_answer = @num1 + @num2
  if @answer == @expected_answer
    true
  else
    false
  end
end

def player1
  puts "Player 1 it's your turn to answer"
  @answer = gets.chomp.to_i
  if !verify_answer?
    @Player1_lives -= 1
    display_score
  end
end

def player2
  puts "Player 2 it's your turn to answer"
  @answer = gets.chomp.to_i
  if !verify_answer?
    @Player2_lives -= 1
    display_score
  end
end

def announce_winner
  if @Player2_lives == 0
    puts "Player 1 wins!"
  else
    puts "Player 2 wins"
  end
end

loop do
  generate_number
  p "What does #{@num1} plus #{@num2} equal?"
  player1
  break if @Player1_lives == 0 
  player2
  break if @Player2_lives == 0
end

announce_winner








