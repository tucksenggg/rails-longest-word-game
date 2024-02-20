require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      random = ('a'..'z').to_a.sample.upcase
      @letters << random
    end
  end

  def score
    @word = params[:word]
    letters = params[:letters]

    check_input =
      @word.upcase.chars.all? do |char|
        @word.upcase.chars.count(char) <= letters.count(char)
      end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    open_url = URI.open(url).read
    checker = JSON.parse(open_url)

    @result =
      if check_input
        if checker['found']
          "Congratulations! #{@word} is a valid English word!"
        else
          "Sorry but #{@word} does not seem to be a valid English word..."
        end
      else
        "Sorry but #{@word} can't be built out of #{letters}."
      end
  end
end
