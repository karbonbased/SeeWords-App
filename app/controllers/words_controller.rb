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
		    "entry" => "sound"
		  }
		  # puts "=================="
		  # p response
		  # puts "=================="
	end

	def new
		# @team = Team.find(params[:team_id].to_i)
		@word = Word.new
	end

	def create
		input = params['inputwords']
		puts "=============="
		p input
		puts "=============="

		@word = input

		@response = Unirest.post "https://twinword-word-associations-v1.p.mashape.com/associations/",
		  headers:{
		    "X-Mashape-Key" => $twinwordkey,
		    "Content-Type" => "application/x-www-form-urlencoded",
		    "Accept" => "application/json"
		  },
		  parameters:{
		    "entry" => "sound"
		  }
		  # puts "=================="
		  # p response
		  # puts "=================="

	end

	private


	def word_params
		params.require(:words).permit(:inputwords)
	end

end
