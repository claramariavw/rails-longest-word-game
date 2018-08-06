require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @letters = []

    10.times do
      letter = ('a'..'z').to_a.sample
      @letters << letter
    end

  end

  def score
    @word = params[:word]
    @used_letters = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    encoded_url = URI.encode(url)
    dictionary = open(encoded_url).read
    dictionary_test = JSON.parse(dictionary)

    if @word.chars.all? { |l| @used_letters.count(l) >= @word.count(l) }
      @answer = "Congrats! #{@word} is a valid English Word"
      @score = session[:score].nil? ? 0 : session[:store]
      @score += @word.length
      session[:score]= @score
    else
      @answer = "Sorry, #{@word} can't be built out of #{@used_letters}"
    end

    @answer = "Sorry #{@word} does not seem to be an English Word" unless dictionary_test['found'] == true



    # if dictionary_test['found'] == true
    #   if @word.chars.all? { |l| @used_letters.count(l) == @word.count(l) }
    #     @answer = "Congrats! #{@word} is a valid English Word"
    #   else
    #     @answer = "Sorry, #{@word} can't be built out of #{@used_letters}"
    #   end
    # else
    #   @answer = "Sorry #{@word} does not seem to be an English Word"
    # end
  end

end





