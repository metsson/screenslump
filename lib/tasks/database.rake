require 'models/slump'

namespace :db => :environment do
	desc 'Fetch new movies and series from omdapi.com'
	task :getmovies do		
		Slump.get_new_movies
	end
end