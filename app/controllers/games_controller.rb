require 'open-uri'
require 'json'
class GamesController < ApplicationController

  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end

  # The method returns true if the block never returns false or nil
  def letter_in_grid
    @answer.chars.sort.all? { |letter| @letters.include?(letter) }
  end

  def score
    @letters = params[:letters]
    @answer = params[:answer]
    grid_letters = @letters.each_char { |letter| print letter, '' }
    if letter_in_grid
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{grid_letters}."
    elsif !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    elsif letter_in_grid && !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    else letter_in_grid && !english_word
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    end
  end
end
