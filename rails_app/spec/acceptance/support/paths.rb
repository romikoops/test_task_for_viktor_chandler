module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    '/'
  end

  def new_game_page
    '/games/new'
  end

  def view_game_page
    /^\/games\/\d+$/
  end

  def games_page
    '/games'
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
