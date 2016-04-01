class WordsController < ApplicationController

	def index
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

		# Perform check against Word Associations API to ensure there is a match prior to creating
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
		 
	  	p @response.body["associations"]

		# GET ARRAY OF WORD ASSOCIATIONS
		results_array = @response.body["associations"]

		# if there is no response from the word association API, redirect to the retry path
	   	if results_array.nil?
	   		puts "********* ERROR OCCURED ********** WORD NOT FOUND *********"
		  	redirect_to words_retry_path
	  	else

			@word = Word.new(input)

			results_split = results_array.split(/\s*,\s*/)
		
		  	# POP 14 items from the array, leaving 16 to cut the time in half
		  	results_split.pop(14)

		  	results_split.each do |result|
			  	new_results = Result.create(origin_word: search, result_word: result)
			  	@word.results << new_results

			  	#GIPHY API CALL TO begin save to database test, use if else for no results
			  	api_call = "http://api.giphy.com/v1/gifs/search?q="+result+"&api_key=dc6zaTOxFJmzC&limit=1"
			    results =  JSON.parse(HTTParty.get(api_call).body)['data']
				first = results[0]

				# if the request has no results, delete that result from the Result database
				if first.nil?
					unfound_result = Result.find_by(result_word: result)
					unfound_result.destroy
					puts "******** no gif found for the result word... ********"
					p result
					puts "***** it been destroy from the database *****"
				# else parse the request and save the url to the result
				else
					images = first["images"]
					image = images["fixed_height"]
					@image_url = image["url"]
					new_results.update(:url => @image_url)
				end #closes if loop on giphy API call
			end # Close of .each do loop
			redirect_to results_path
		end #close of if else for arry_nil check redirects
  	end # close of create method


	def retry
	end

	def test
	end

	# PRIVATE SECTION
	private


	def word_params
		params.require(:words).permit(:inputwords)
	end

end
