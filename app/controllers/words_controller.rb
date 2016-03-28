class WordsController < ApplicationController

	def index
		# These code snippets use an open-source library. http://unirest.io/ruby
		@response = Unirest.post "https://twinword-word-associations-v1.p.mashape.com/associations/",
		  headers:{
		    "X-Mashape-Key" => $twinwordkey,
		    "Content-Type" => "application/x-www-form-urlencoded",
		    "Accept" => "application/json"
		  },
		  parameters:{
		    "entry" => "burger"
		  }
		  # puts "=================="
		  # p response
		  # puts "=================="
	end

	def show
		@words = @results.words
	end


	def new
		# @team = Team.find(params[:team_id].to_i)
		@word = Word.new
	end

	def create
		# GET USER INPUT AND CREATE 2 IMPORTANT VARIABLES 
		# SEARCH -> String to be passed into request for associations
		# INPUT -> Hash to be passed into DB
		search = params['inputwords']
		input = {name: search}
		puts "=============="
		p input
		puts "=============="

		@word = Word.new(input)


		if @word.save
			puts "**************************"
			puts "**************************"
			puts "**** new word created! ***"
			puts "**************************"
			puts "**************************"
		else
			puts "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
			puts "±±±±± creation failed ±±±±±±±±"
			puts "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
		end

		# GET WORD ASSOCIATIONS WITH THE USER SEARCH
		@response = Unirest.post "https://twinword-word-associations-v1.p.mashape.com/associations/",
		  headers:{
		    "X-Mashape-Key" => $twinwordkey,
		    "Content-Type" => "application/x-www-form-urlencoded",
		    "Accept" => "application/json"
		  },
		  parameters:{
		    "entry" => search
		  }
		  puts "=================="
		  p response
		  puts "=================="

		  # GET ARRAY OF WORD ASSOCIATIONS
		  results_array = @response.body["associations"].split(/\s*,\s*/)
		  puts "//////////////////////////////////////"
		  puts "//////////////////////////////////////"
		  p results_array
		  puts "//////////////////////////////////////"
		  puts "//////////////////////////////////////"

		  # word.results = 

		  results_array.each do |word|
		  	new_results = Result.create(origin_word: search, result_word: word)
		  	puts "****************************************"
		  	puts "********* new_results is ***************"
		  	puts new_results
		  	puts "****************************************"
		  	puts "****************************************"
		  	word.results << new_results
		  end



		  redirect_to :root

	end

	private


	def word_params
		params.require(:words).permit(:inputwords)
	end

end
