class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    new_movie = Movie.new
    new_movie.title = params[:query_title]
    new_movie.year = params[:query_year]
    new_movie.duration = params[:query_duration]
    new_movie.description = params[:query_description]
    new_movie.image = params[:query_image]
    new_movie.director_id = params[:query_director_id]

    if new_movie.save
      redirect_to("/movies")
    end
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Movie.where({ :id => the_id })

    the_movie = matching_records.at(0)

    the_movie.destroy

    redirect_to("/movies")
  end

  def update
    the_id = params[:path_id]
    movie = Movie.find_by(id: the_id)

    movie.title = params[:query_title]
    movie.year = params[:query_year]
    movie.duration = params[:query_duration]
    movie.description = params[:query_description]
    movie.image = params[:query_image]
    movie.director_id = params[:query_director_id]

    if movie.save
      redirect_to("/movies/#{movie.id}") 
    end
end
  
end
