class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game ||= Game.new
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to(@game, :notice => 'Game was successfully created.')  
    else
      render :action => :new
    end
  end

end
