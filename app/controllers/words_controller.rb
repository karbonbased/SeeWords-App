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
		  puts "=================="
		  p response
		  puts "=================="
	end

	def show
		@words = @words.results
	end


	def new
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
			puts "**** new word created! ***"
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
		  p results_array
		  puts "//////////////////////////////////////"


		  results_array.each do |result|
		  	new_results = Result.create(origin_word: search, result_word: result)
		  	puts "****************************************"
		  	puts "********* new_results is ***************"
		  	puts new_results
		  	puts "****************************************"
		  	puts "****************************************"
		  	@word.results << new_results
		  end

		  redirect_to results_path

	end

	def test
		api_call = "http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"
	
	    @results =  JSON.parse(HTTParty.get(api_call).body)['data']
		puts "*************************"
		@first = @results[0]		
		@images = @first["images"]
		puts "*************************"
		puts "*************************"
		p @images
		puts "*****************************"
		puts "***** @images[fixed_height] is  ********"
		p @images["fixed_height"]
		image = @images["fixed_height"]
		puts "****** image url is *******************"
		p image["url"]
		@image_url = image["url"]
		puts "*************************"

	end

	# PRIVATE SECTION
	private


	def word_params
		params.require(:words).permit(:inputwords)
	end

end
