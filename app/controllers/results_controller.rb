class ResultsController < ApplicationController

	def index
		@lastword = Word.last
		puts "********************"
		p @lastword
		puts "********************"

		api_call = "http://api.giphy.com/v1/gifs/search?q="+@lastword.name+"&api_key=dc6zaTOxFJmzC"
	
	    results =  JSON.parse(HTTParty.get(api_call).body)['data']
		puts "*************************"
		first = results[0]	
		images = first["images"]
		image = images["fixed_height"]
		@image_url = image["url"]

		@lastword.results.each do |result|
		# 	puts "***********************"
			# p result.result_word
		# 	puts "***********************"
			output = result.result_word
			api_call = "http://api.giphy.com/v1/gifs/search?q="+output+"&api_key=dc6zaTOxFJmzC"
		# 	puts "************"
			p api_call
		# 	puts "************"
			@testresult = JSON.parse(HTTParty.get(api_call).body)['data']
			p @testresult
		# 	puts "*************************"
			@first = @testresult[0]
			puts "***************"
			p @first
			puts "***************"
			# @pictures = @first["images"]
			# image = images["fixed_height"]
			# @image_url = image["url"]
		end

	end
end
