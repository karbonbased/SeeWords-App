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
	end

	def show
		@result = Result.find(params[:id])
	end
		
end
