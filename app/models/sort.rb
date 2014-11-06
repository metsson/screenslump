class Sort < ActiveRecord::Base
	has_many :movies
	
	before_create :normalize!

private
	def normalize!
		if self.name.blank? or self.name.length < 2
			raise 'The sort name cannot be shorter than two (2) characters.'
		else
			self.name.downcase
		end
	end
end
