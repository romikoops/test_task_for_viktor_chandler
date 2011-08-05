class Game < ActiveRecord::Base
   validates_presence_of :title, :description
   validates_attachment_presence :image
   
   has_many :game_players
   has_many :players, :through => :game_players

   has_attached_file :image,
                     :path => ":rails_root/public/images/:id/:style/:basename.:extension",
                     :url  => "/images/:id/:style/:basename.:extension"

end
