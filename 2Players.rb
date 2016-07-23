require_relative '2players_classes.rb'
require 'colorize'

reply = " "

def valid_input?(input)
  input == 'y' || input == 'n'
end

loop do 
  puts "Want to see who is better at Math? (y/n)"
  reply = gets.chomp.downcase

  break if valid_input?(reply)
  puts "Invalid Input!!".colorize(:yellow)
end

exit if reply == 'n'  

puts "Who should play first? Give me a mathematician's name"
player1 = gets.chomp

puts "Who should challenge #{player1}? Give me a mathematician's name"
player2 = gets.chomp

game = Game.new(player1, player2)
puts game.display_current_players
puts " "

loop do
  game.reset_player_lives

  loop do # question loop
    puts game.ask_a_question.colorize(:green)
    game.get_players_answer
    puts game.display_players_answer.colorize(:blue)
    game.evaluate_answer
    puts game.display_player_status
    break if game.no_more_lives?
  end
  
  loop do
    puts "Continue? (y/n)"
    reply = gets.chomp.downcase
    break if valid_input?(reply)
    puts "Invalid Input".colorize(:yellow)
  end

  break if reply == 'n'
end

puts "A total of #{Question.return_number_of_questions} questions were asked"