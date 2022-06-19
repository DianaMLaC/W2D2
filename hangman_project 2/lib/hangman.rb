class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index do |letter, idx|
      if letter == char
      indices << idx
      end
    end
    indices
  end

  def fill_indices(char, indices)
    indices.each do |idx|
      guess_word[idx] = char
    end
  end 

  def try_guess(char)
    if self.already_attempted?(char)
      puts "that was already attempted"
      return false
    end
    
    @attempted_chars << char
    
    matches = self.get_matching_indices(char)
    self.fill_indices(char, matches)

    @remaining_incorrect_guesses -= 1 if matches.empty?
    
    true
  end

  def ask_user_for_guess
    puts "Enter a char:"
    guess = gets.chomp
    self.try_guess(guess)
  end

  def win?
    if @guess_word.all? {|ele| @secret_word.include?(ele)}
      puts "WIN"
      true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      true
    else
      false
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    else
      false
    end
  end


      




  

end
