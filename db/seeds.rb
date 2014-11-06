require 'open-uri'

# omdapi does (of understandable reasons) not like this, so do it as little as possible!
random_words = ['put', 'war', 'hunt', 'hello', 'more', 'find', 'peace', 'hero', 'when', 'once', 'take', 'home', 'sweet', 'turn']

10.times do 
	random_words << Faker::Name.first_name
end

random_words.each { |random|  
	puts 'Searching for #{random}'

	@slump = JSON.parse open("http://www.omdbapi.com/?s=#{random}").read

	if @slump and @slump['Search']
		for hit in @slump['Search'] 
			unless hit['Type'] === 'episode'
				slump = JSON.parse open("http://www.omdbapi.com/?i=#{hit['imdbID']}").read

				# Create new slump aka movie/series record
				if slump and slump['Response'] === 'True'
					if !slump['imdbID'].blank? and (!slump['Plot'].blank? or slump['Plot'] != 'N/A')
						
						existing = Slump.find_by(imdbid: slump['imdbID'])

						if existing.nil?
							new_slump = Slump.create(
								title: slump['Title'],
								plot: slump['Plot'],
								imdbid: slump['imdbID'],
								year: slump['Year'].to_i)

							new_slump.sort = Sort.find_or_create_by(name: slump['Type'])
							new_slump.save

							puts '1 movie added'
						end
					end
				end
			end
		end
	else
		puts 'Response from omdapi not valid'
	end
}