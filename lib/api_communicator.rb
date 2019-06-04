require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request

  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  films = []
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  response_hash["results"].each do |character_name|
    films_array = character_name["films"]

      films_array.each do |film_url|
        one_film = RestClient.get(film_url)
        one_parsed_film = JSON.parse(one_film)
        films << one_parsed_film
    end
  end
  films
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.uniq.map do |x|
    one_title = x["title"]
    one_director = x["director"]
    one_date = x["release_date"]
    puts "Title: #{one_title}"
    puts "Director: #{one_director}"
    puts "Release Date: #{one_date}"
    puts "\n\n"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
