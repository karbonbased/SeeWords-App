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
		# puts "=============="
		# p input
		# puts "=============="

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
		 
		  puts "********** THIS IS  response.body **********"
		  p @response.body
		  puts "*****************"
		  p @response.body["associations"]

		  # GET ARRAY OF WORD ASSOCIATIONS
		  results_array = @response.body["associations"]

	   	if results_array.nil?
	   		puts "^^^^^^^^^^^^ ERROR OCCURED ^^^^^^^^^^^^^ fuck."

	  		# @error = "ERROR HAS OCCURED" 
		  	redirect_to words_retry_path
	  	else

				@word = Word.new(input)

				results_split = results_array.split(/\s*,\s*/)
		
		  	# POP 14 items from the array, leaving 16 to cut the time in half
		  	results_split.pop(14)

		  	results_split.each do |result|
			  	# puts "////////// result is ///////////////"
			  	# p result
			  	# puts "///////////////////////////////////"
			  	new_results = Result.create(origin_word: search, result_word: result)
			  	@word.results << new_results

			  	# puts "////////// result is ///////////////"
			  	# p result@imageurl = @images["imageurl"]
			  	# puts "///////////////////////////////////"
			  	# puts "******* result ****************"
			  	# p result
			  	# puts "******************************************"
			  	#GIPHY API CALL TO begin save to database test, use if else for no results
			  	api_call = "http://api.giphy.com/v1/gifs/search?q="+result+"&api_key=dc6zaTOxFJmzC&limit=1"
	
			    results =  JSON.parse(HTTParty.get(api_call).body)['data']
			    puts "******************** results[0] is ***************************"
			    p results[0]
			    puts "*************************************************"
				
				first = results[0]

				if first.nil?
					unfound_result = Result.find_by(result_word: result)
					unfound_result.destroy
					puts "*********************************"
					p unfound_result
					puts "******** item has been deleted from database ********"
				else
					images = first["images"]
					image = images["fixed_height"]
					@image_url = image["url"]
					puts "******** @imageurl is **************"
					p @image_url
					puts "************************************"
					new_results.update(:url => @image_url)
				end #closes if loop on giphy API call
			end # Close of .each do loop
			redirect_to results_path
		end #close of if else for arry_nil check redirects
  	end # close of 


		# # GET WORD ASSOCIATIONS WITH THE USER SEARCH
		# @response = Unirest.post "https://twinword-word-associations-v1.p.mashape.com/associations/",
		#   headers:{
		#     "X-Mashape-Key" => $twinwordkey,
		#     "Content-Type" => "application/x-www-form-urlencoded",
		#     "Accept" => "application/json"
		#   },
		#   parameters:{
		#     "entry" => search
		#   }
		 
		#   puts "********** THIS IS  response.body **********"
		#   p @response.body
		#   puts "*****************"
		#   p @response.body["associations"]

		#   # GET ARRAY OF WORD ASSOCIATIONS
		#   results_array = @response.body["associations"]

		  # if results_array.nil?
		  # 	@error = "ERROR HAS OCCURED" 
		  # 	return
		  # else
		#   results_split = results_array.split(/\s*,\s*/)
		
		#   # POP 14 items from the array, leaving 16 to cut the time in half
		#   results_split.pop(14)

		#   results_split.each do |result|
		#   	# puts "////////// result is ///////////////"
		#   	# p result
		#   	# puts "///////////////////////////////////"
		#   	new_results = Result.create(origin_word: search, result_word: result)
		#   	# puts "****************************************"
		#   	# puts "********* new_results is ***************"
		#   	# puts new_results
		#   	# puts "****************************************"
		#   	# puts "****************************************"
		#   	@word.results << new_results

		#   	# puts "////////// result is ///////////////"
		#   	# p result@imageurl = @images["imageurl"]
		#   	# puts "///////////////////////////////////"

		#   	# PIXPLORER API CALL ON result begin to save to database test
		#   	api_call = "http://api.pixplorer.co.uk/image?word="+result+"&amount=1&size=m"
		#   	response = JSON.parse(HTTParty.get(api_call).body)['images']
		# 	images = response[0]
		# 	@imageurl = images["imageurl"]
		# 	puts "******** @imageurl is **************"
		# 	p @imageurl
		# 	puts "************************************"
		# 	new_results.update(:url => @imageurl)
		# end

		  
		# end

	# 	  redirect_to results_path

	# end

	def retry
		@lastword = Word.last
	end

	def test
		# api_call = "http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"
	
	 #    @results =  JSON.parse(HTTParty.get(api_call).body)['data']
		# puts "*************************"
		# @first = @results[0]		
		# @images = @first["images"]
		# puts "*************************"
		# puts "*************************"
		# p @images
		# puts "*****************************"
		# puts "***** @images[fixed_height] is  ********"
		# p @images["fixed_height"]
		# image = @images["fixed_height"]
		# puts "****** image url is *******************"
		# p image["url"]
		# @image_url = image["url"]
		# puts "*************************"

	end

	# PRIVATE SECTION
	private


	def word_params
		params.require(:words).permit(:inputwords)
	end

end
