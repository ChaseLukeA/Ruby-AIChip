# guess_the_number.rb
# By Luke A Chase
# chase.luke.a@gmail.com
# Copyright 2015

# /-------------------------------FUNCTIONS-----------------------------------\
def pc_speak(message)
  print "\n$ "
  characters = message.split("")
  characters.each do |char|
    print char
    if char =~ /\A[ |.|,|:|;]\Z/
      sleep 0.08
    else
      sleep 0.02
    end
  end
end

def pc_prompt(question)
  pc_speak(question)
  gets.chop
end

def prompt(question)
  print question
  gets.chop
end

# accepts input value and regular expression to check, returns true or false
def valid_input(input, regex)
  !!(input =~ regex)
end

def check_answer(guessed_number, actual_number)
  if guessed_number == actual_number
    :match
  elsif guessed_number < actual_number
    :low
  else
    :high
  end
end

def game_won_message(guess_total)
  message = "You guessed my number in #{guess_total} "

  if guess_total == 1
    message += "guess"
  else
    message += "guesses"
  end

  case guess_total
  when 1
    message += "! You are a mind reader!"
  when 2, 3, 4
    message += "! That is most impressive."
  when 5, 6
    message += ". You can do better than that."
  else
    message += ". Better luck next time."
  end
end
# \---------------------------------------------------------------------------/

# /----------------------------------MAIN-------------------------------------\
# Global declarations
play_game = false
difficulty = [10, 100, 1000]

# Welcome, Chip ;)
pc_speak "Hi, I'm Chip. ;)\n"
sleep 0.50
pc_speak "Would you like to play a game? "
sleep 0.25
play_game = prompt("\('y' or 'n'\):\n> ") =~ /\A[y|Y]\Z/

while play_game do
  # New game declarations
  number_of_guesses = 0
  game_won = false

  game = pc_prompt "What game would you like to play?\n> "

  if game == "guess the number"
    pc_speak "Oh! I know that one! Lets play! =)\n"
  else
    pc_speak "I am sorry, I do not know \"#{game}\" but I am sure it is fun.\n"
    pc_speak "Lets play \"guess the number\" instead. :)\n"
  end

  begin
    difficulty_level = pc_prompt "Choose a difficulty level => 1, 2, or 3:\n> "
  end while !valid_input(difficulty_level, /\A[1|2|3]\Z/)
  difficulty_level = difficulty[difficulty_level.to_i-1]

  pc_speak "OK. I will think of a number from 1 to #{difficulty_level}\n\n\tThinking"
  8.times do
    print "."
    sleep 0.25
  end
  print "\n"

  actual_number = 1 + rand(difficulty_level)
  pc_speak "Ok, I have a number in mind. What is your guess?\n"

  while !game_won do
    guessed_number = prompt "> Enter guess: "
    number_of_guesses += 1

    if valid_input(guessed_number, /\A[0-9]+\Z/)
      case check_answer(guessed_number.to_i, actual_number.to_i)
      when :match
        game_won = true
        pc_speak "#{game_won_message(number_of_guesses)}\n"
      when :low
        pc_speak "Too low. Guess again.\n"
      when :high
        pc_speak "Too high. Guess again.\n"
      end
    else
      pc_speak "I'm sorry, you must enter a valid integer. Please try again."
    end
  end


  pc_speak "Would you like to play another game? "
  play_game = prompt("\('y' or 'n'\):\n> ") =~ /\A[y|Y]\Z/
end

pc_speak "Thank you. I enjoyed our interaction.\n"
sleep 0.50
pc_speak "Goodbye.\n\n"
# \---------------------------------------------------------------------------/
