class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :slump_stats

  # Simple method for footer stats
  def slump_stats
  	@@count ||= Slump.count
  	@@today ||= Slump.where('created_at > ?', "#{2.days}")
  	
  	stat = "#{@@count} slumps"
  	
  	if @@today.size > 0
  		stat +=  ". #{@@today.size} added today" 
  	end

  	return stat
  end
end
