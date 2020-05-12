class Api::V1::MoviesController < Api::V1::ApiController
  before_action :set_movie, only: [:update, :show, :destory]
  before_action :require_authentication!, only: [:update, :show, :destroy]

  def index
    @movies = current_user.movies

    render json: @movies
  end

  def show
    render json: @movie
  end

  def create
    @movie = Movie.new(movie_params).merge(user: current_user)

    if @movie.save
      render json: @movie, status: :created
    else
      render json: @movie.errors, status: unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :director, :duration_min, :release_year)
  end

  def require_authorization!
    unless current_user == @movie.user
      render json: {}, status: :forbidden
    end
  end
end
