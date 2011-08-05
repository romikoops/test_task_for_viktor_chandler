class Player < ActiveRecord::Base
  validates_presence_of :name
  
  has_many :games
  has_many :games, :through => :game_players
end
