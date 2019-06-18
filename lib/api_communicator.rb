require 'rest-client'
require 'JSON'
require 'pry'



def get_character_movies_from_api(character_name)
  
  film_array = []
  
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_array = JSON.parse(response_string)["results"]
  
  
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`

  character = response_array.find {|char| char['name'].downcase == character_name}

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  
  films = character['films']

 character_films = films.collect do |url|
    response_string = RestClient.get(url)
    response_array = JSON.parse(response_string)
  end


  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  
  

end 
  
    
  
      
      

    
  
  
  
  
  
  
  
  
  
  

  def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |movie|
    puts "#{movie['title']}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
