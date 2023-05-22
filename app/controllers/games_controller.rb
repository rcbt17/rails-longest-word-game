require 'open-uri'

class GamesController < ApplicationController
  def start
    @letters = (1..10).map { rand(65..90).chr }.join
  end

  def results
    is_valid = true
    word = params[:answer].upcase
    original = params[:original_letters].upcase
    word.chars.each do |character|
      if word.chars.count(character) > original.chars.count(character)
        @is_valid = false
      end
    end
    @score = "Score is 0. Wrong answer!"
    if is_valid
      link = "https://wagon-dictionary.herokuapp.com/#{word}"
      result = JSON.parse(URI.open(link).read)
      if result["found"] == true
        @score = "Score is #{result['length'] * 10} out of 100"
      end
    end
  end
end
