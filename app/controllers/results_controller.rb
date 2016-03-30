class ResultsController < ApplicationController

	def index
		@lastword = Word.last
		# puts "********************"
		# p @lastword
		# puts "********************"

		# create an API call to Pixplorer, parameters set to amount=1 & size=m to get 1 result in medium size
		api_call = "http://api.giphy.com/v1/gifs/search?q="+@lastword.name+"&api_key=dc6zaTOxFJmzC&limit=1"
	
	    results =  JSON.parse(HTTParty.get(api_call).body)['data']
		
		first = results[0]

		if first.nil?
			@nogif = "Sorry No Gif Available For Your Source Word"
		else
			images = first["images"]
			image = images["fixed_height"]
			@image_url = image["url"]
		end

		@wordresults = @lastword.results
		


		# Iteration will use Pixplorer to get an image per result_word as Giphy API returns nil too frequently, breaking the loop
		# create an API call to Pixplorer, parameters set to amount=1 & size=m to get 1 result in medium size (open API)
		# @lastword.results.each do |result|
		# 	output = result.result_word
		# 	api_call = "http://api.pixplorer.co.uk/image?word="+output+"&amount=1&size=m"
		# 	puts "********************* api_call is ***************************"
		# 	p api_call
		# 	puts "*************************************************************"
		# 	@response = JSON.parse(HTTParty.get(api_call).body)['images']
		# 	@images = @response[0]
		# 	p @images
		# 	puts "++++++++++++++"
		# 	@imageurl = @images["imageurl"]
		# 	p @imageurl
		# end

		

	end
end
