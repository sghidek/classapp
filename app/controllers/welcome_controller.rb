class WelcomeController < ApplicationController
  def test
	response = HTTParty.get("http://www.omdbapi.com/?apikey=#{ENV['omdb_api_key']}&t=surface")
  
	  @title = response['Title']
	  @year = response['Year']
	  @plot = response['Plot']
	  @actors = response['Actors']

  end


  def index

    # Creates an array of states that our user can choose from on our index page
    @shows = %w(Banshee Eastbound\ &\ Down Going\ to\ California Good\ Behavior Little\ Britain\ USA One\ Tree\ Hill Port\ City\ PD Revolution Secrets\ and\ Lies Six Sleepy\ Hollow&y=2013 Surface Under\ the\ Dome Whittaker\ Bay Witches\ of\ East\ End).sort!

    # removes spaces from the 2-word city names and replaces the space with an underscore 
      if params[:shows] != nil
          params[:shows].gsub!(" ", "+")
      end


    #checks that the show params are not empty before calling the API

      if params[:shows] != "" && params[:shows] != nil 
		 
	 results = HTTParty.get("http://www.omdbapi.com/?apikey=#{Figaro.env.omdb_api_key}&t=#{params[:shows]}")
		

#if no error is returned from the call, we fill our instants variables with the result of the call


        #Checks to see if the response contains an array (ambigous response for an invalid city/state combination) or a hash(valid response)
            if results.key?("Title") 
			  @title = results['Title']
			  @poster = results['Poster']
			  @year = results['Year']
			  @plot = results['Plot']
			  @actors = results['Actors']
        	end
    	end


  end

end
