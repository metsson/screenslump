require 'open-uri'

class Slump < ActiveRecord::Base
	belongs_to :sort
	

	# Utilized by task for fetching new data
	def self.get_new_slumps
		# omdapi does (of understandable reasons) not like this, so do it as little as possible!
		random_movie = self.offset(rand(self.count)).first
		random_words = random_movie.plot.split(' ').delete_if { |w| w.length < 4 }
		
		random_words.each do |random|  

			fetch = JSON.parse open("http://www.omdbapi.com/?s=#{random}").read

			if fetch and fetch['Search']
				for hit in fetch['Search'] 
					unless hit['Type'] === 'episode'
						slump = JSON.parse open("http://www.omdbapi.com/?i=#{hit['imdbID']}").read

						# Create new slump aka movie/series record
						if slump and slump['Response'] === 'True'
							if !slump['imdbID'].blank? and (!slump['Plot'].blank? or slump['Plot'] != 'N/A')
								
								existing = Slump.find_by(imdbid: slump['imdbID'])

								if existing.nil?
									new_slump = self.create(
										title: slump['Title'],
										plot: slump['Plot'],
										imdbid: slump['imdbID'],
										year: slump['Year'].to_i)

									new_slump.sort = Sort.find_or_create_by(name: slump['Type'])
									new_slump.save
								end
							end
						end
					end
				end
			end
		end
	end
end
