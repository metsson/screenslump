class SlumpController < ApplicationController
	def index
		@slump = Slump.offset(rand(Slump.count)).first	
	end

	def show 
		if params[:id]
			@slump = Slump.find(params[:id])
		else
			redirect_to root_url
		end
	end

	def fetch
		Slump.get_new_slumps
		redirect_to root_url
	end
end