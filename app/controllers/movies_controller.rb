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
     
     @all_ratings = Movie.ratings           #get the ratings from Model   
     @sort_column=params[:sort] || session[:sort]   # set the column to be sorted from parameters or previous session
     session[:ratings] = session[:ratings] || {'G'=>'','R'=>'','PG-13'=>'','PG'=>''}  
     @var_param = params[:ratings] || session[:ratings]
     session[:sort]= @sort_column
     session[:ratings]= @var_param
     @movies=Movie.where(rating: session[:ratings].keys).order(session[:sort])   #show movies with selected ratings and sort by column selected
     #@movies=Movie.all.order(@sort_column) #part1
     
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
