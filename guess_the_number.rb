# Functions
# /---------------------------------------------------------------------------\

def prompt(question)
  print question
  gets.chop
end

def valid_input(input, regex)
  !!(input =~ regex)
end

def check_answer(guessed_number, actual_number)
  if guessed_number == actual_number
    return true
  else
    if guessed_number < actual_number
      puts "Too low. Guess again: "
    else
      puts "Too high. Guess again: "
    end
    return false
  end
end

def game_won_message(guess_total)
  message = "You got it in #{guess_total} "

  if guess_total == 1
    message += "guess! "
  else
    message += "guesses! "
  end

  case guess_total
  when 1
    message += "You're a mind reader!"
  when 2, 3, 4
    message += "Most impressive."
  when 5, 6
    message += "You can do better than that."
  else
    message += "Better luck next time."
  end
end





# \---------------------------------------------------------------------------/

keep_playing = true
difficulty = [10, 100, 1000]

puts ".-------------------------------------------------------."
puts "|              Lets Play Guess The Number               |"
puts "'-------------------------------------------------------'\n"

while keep_playing do

  # Each turn variables
  number_of_guesses = 0
  game_won = false

  begin
    difficulty_level = prompt "\nPick a difficulty level (1, 2, or 3): "
  end while !valid_input(difficulty_level, /\A[1|2|3]\Z/)

  difficulty_level = difficulty[difficulty_level.to_i-1]
  puts "Difficulty level: 1 to #{difficulty_level}\n\n"
  print "  Thinking"

  9.times do
    print "."
    sleep 0.25
  end

  actual_number = 1 + rand(difficulty_level)
  puts "\n\nOk I have a number in mind. What is your guess?\n"

  while !game_won do
    guessed_number = prompt "Enter guess: "
    number_of_guesses += 1
    puts

    if valid_input(guessed_number, /\A[0-9]+\Z/)
      game_won = check_answer(guessed_number.to_i, actual_number.to_i)
    else
      puts "* You must enter a valid integer. Try again. *"
    end

  end

  puts "#{game_won_message(number_of_guesses)}\n\n"

  keep_playing = false if prompt("Play again? ") =~ /\A[n|N]\Z/
end

