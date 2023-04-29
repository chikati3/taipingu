class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :same_name_history, only: [:new, :create]


  def index
  end

  def search
    games = current_user&.games || []
    render json: { games: games }
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    if @game.save
      redirect_to new_game_path
    else
      render :new
    end
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to new_game_path
  end

  private
  def game_params
    params.require(:game).permit(:title, :answer).merge(user_id: current_user.id)
  end

  def same_name_history
    @nickname = current_user.nickname
    @games = current_user.games.order("created_at DESC")
  end
end
