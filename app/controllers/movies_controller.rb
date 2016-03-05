class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings
    movies = Movie.all
    
    if (params[:column] == nil and session[:column] != nil) and (params[:ratings] == nil and session[:ratings] != nil)
      redirect_to sort_movies_path(:column => session[:column], ratings: session[:ratings], commit: 'Refresh')
    elsif params[:ratings] == nil and session[:ratings] != nil and params[:column] != nil
      redirect_to sort_movies_path(:column => params[:column], ratings: session[:ratings], commit: 'Refresh')
    elsif params[:column] == nil and session[:column] != nil and params[:ratings] != nil
      redirect_to sort_movies_path(:column => session[:column], ratings: params[:ratings], commit: 'Refresh')
    end
    
    if params[:ratings] != nil
      params[:ratings].each do |rating|
      end
      session[:ratings] = params[:ratings]
      movies = Movie.all.where(rating: session[:ratings].keys)
    else
      session.delete(:ratings)
    end
    
    if params[:column] != nil
      session[:column] = params[:column]
      movies = movies.order(session[:column])
    end
    @movies = movies
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
