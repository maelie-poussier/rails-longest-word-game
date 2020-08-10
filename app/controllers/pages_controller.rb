require 'open-uri'
require 'json'

class PagesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    return @letters
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid]
    grid_letters = @grid.each_char { |letter| print letter, '' }
    if letter_in_grid == false
      @result = "Sorry, but #{@word.upcase} can’t be built out of #{grid_letters}."
    elsif english_word == false
      @result = "Sorry but #{@word.upcase} does not seem to be an English word."
    elsif letter_in_grid && english_word
      @result = "Congratulation! #{@word.upcase} is a valid English word."
    end
  end

  def letter_in_grid
    @word.chars.all? { |letter| @grid.include?(letter) }
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end
end
