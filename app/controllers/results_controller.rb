class ResultsController < ApplicationController

	def index
		@lastword = Word.last
		puts "********************"
		p @lastword
		puts "********************"

		# create an API call to Giphy, limit=1 because we just need the first
		api_call = "http://api.giphy.com/v1/gifs/search?q="+@lastword.name+"&api_key=dc6zaTOxFJmzC&limit=1"
	
	    results =  JSON.parse(HTTParty.get(api_call).body)['data']
		first = results[0]	
		images = first["images"]
		image = images["fixed_height"]
		@image_url = image["url"]

		@lastword.results.each do |result|
			output = result.result_word
			api_call = "http://api.giphy.com/v1/gifs/search?q="+output+"&api_key=dc6zaTOxFJmzC&limit=1"
			puts "**************** api_call is **********************"
			p api_call
			puts "***************************************************"
			@testresult = JSON.parse(HTTParty.get(api_call).body)['data']
			puts "*************** @testresult from API is **********************"
			p @testresult
			puts "**************************************************************"
			puts "****** @testresult[0] is ********"
			p @testresult[0]
			puts "*********************************"
			@first = @testresult[0]
			puts "*********** @first is ***********"
			p @first
			puts "*********************************"
			# images = @first["images"]
			# image = images["fixed_height"]
			# @image_url = image["url"]
		end
	end
end
