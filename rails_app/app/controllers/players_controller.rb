class PlayersController < ApplicationController
  before_filter :authenticate_admin!
  
  def index
    @players = Player.all
  end

  def edit
    @player ||= Player.find(params[:id])
  end

  def new
    @player ||= Player.new
    render :action => :edit
  end

  def update
    @player ||= Player.find(params[:id])
    @player.update_attributes(params[:player])
    if @player.save
      redirect_to(players_path, :notice => 'Player was successfully updated.')  
    else
      render :action => :edit
    end
  end

  def create
    @player = Player.new
    update
  end
  
  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to(players_path, :notice => 'Player was deleted.')
  end
end
