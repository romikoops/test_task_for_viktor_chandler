require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Game Creation", %q{
  In order to database filling by new games
  As an unregistered user
  I want to have ability to create new game
} do


  scenario "Initiate game creation from Home page" do
    visit homepage
    page.should have_content('Listing games')
    click_link('New Game')
    current_path.should == new_game_page
    page.should have_content('New game')
  end

  scenario "Initiate game creation from url" do
    visit new_game_page
    page.should have_content('New game')
  end

  scenario "Create game with valid data" do
    visit homepage
    click_link('New Game')
    game_title = "Test game #{serial_gen} title"
    game_desc = "Test game #{serial_gen} description"
    image_name = 'poker_cards.jpg'
    within("//form[@id='new_game']") do
      fill_in 'game_title', :with => game_title
      fill_in 'game_description', :with => game_desc
      path_to_file = File.join(get_path_to_test_data, image_name)
      attach_file 'game_image', prepare_path_for_attachment(path_to_file)
    end
    click_button "game_submit"
    current_path.should match(view_game_page)
    page.should have_content('Game was successfully created.')
    page.should have_content("Title: #{game_title}")
    page.should have_content("Description: #{game_desc}")
    page.should have_xpath("//img[contains(@src,'#{image_name}')]")
    visit homepage
    page.should have_content(game_title)
    click_link(game_title)
    current_path.should match(view_game_page)
    page.should have_no_content('Game was successfully created.')
    page.should have_content("Title: #{game_title}")
    page.should have_content("Description: #{game_desc}")
    page.should have_xpath("//img[contains(@src,'#{image_name}')]")
  end

  scenario "Create game with duplicated game data" do
    visit homepage
    click_link('New Game')
    game_title = "Test game #{serial_gen} title"
    game_desc = "Test game #{serial_gen} description"
    image_name = 'poker_cards.jpg'
    within("//form[@id='new_game']") do
      fill_in 'game_title', :with => game_title
      fill_in 'game_description', :with => game_desc
      path_to_file = File.join(get_path_to_test_data, image_name)
      attach_file 'game_image', prepare_path_for_attachment(path_to_file)
    end
    click_button "game_submit"
    visit homepage
    page.should have_content(game_title)
    click_link('New Game')

    within("//form[@id='new_game']") do
      fill_in 'game_title', :with => game_title
      fill_in 'game_description', :with => game_desc
      path_to_file = File.join(get_path_to_test_data, image_name)
      attach_file 'game_image', prepare_path_for_attachment(path_to_file)
    end
    click_button "game_submit"
    page.should have_content('Game was successfully created.')
    visit homepage
    page.source.should match(/#{game_title}.*#{game_title}/m)
  end

  scenario "Try to create game with blank fields" do
    visit homepage
    click_link('New Game')
    game_title = "Test game #{serial_gen} title"
    game_desc = "Test game #{serial_gen} description"
    image_name = 'poker_cards.jpg'

    title_warn = "Title can't be blank"
    desc_warn = "Description can't be blank"
    image_warn = "Image file name must be set."
    error_msg =  'prohibited this game from being saved:'
    errors_title = ' errors ' + error_msg
    single_error_title = '1 error ' + error_msg

    #blank all fields
    click_button "game_submit"
    page.should have_content("3#{errors_title}")
    page.should have_content(title_warn)
    page.should have_content(desc_warn)
    page.should have_content(image_warn)

    #blank title
    within("//form[@id='new_game']") do
      fill_in 'game_description', :with => game_desc
      path_to_file = File.join(get_path_to_test_data, image_name)
      attach_file 'game_image', prepare_path_for_attachment(path_to_file)
    end
    click_button "game_submit"
    page.should have_content(single_error_title)
    page.should have_content(title_warn)
    page.should have_no_content(desc_warn)
    page.should have_no_content(image_warn)

    #blank description
    visit new_game_page
    within("//form[@id='new_game']") do
      fill_in 'game_title', :with => game_title
      path_to_file = File.join(get_path_to_test_data, image_name)
      attach_file 'game_image', prepare_path_for_attachment(path_to_file)
    end
    click_button "game_submit"
    sleep 1
    page.should have_content(single_error_title)
    page.should have_no_content(title_warn)
    page.should have_content(desc_warn)
    page.should have_no_content(image_warn)

    #blank image
    visit new_game_page
    within("//form[@id='new_game']") do
      fill_in 'game_title', :with => game_title
      fill_in 'game_description', :with => game_desc
    end
    click_button "game_submit"
    page.should have_content(single_error_title)
    page.should have_no_content(title_warn)
    page.should have_no_content(desc_warn)
    page.should have_content(image_warn)
  end

  scenario "Create game with title with special characters" do
    special_symbols = "@#$\%^&;.?,>|\\/№\"!()_{}'[<~"
    visit homepage
    click_link('New Game')
    game_title = "Test game #{serial_gen} title #{special_symbols}"
    game_desc = "Test game #{serial_gen} description #{special_symbols}"
    image_name = 'poker_cards.jpg'
    within("//form[@id='new_game']") do
      fill_in 'game_title', :with => game_title
      fill_in 'game_description', :with => game_desc
      path_to_file = File.join(get_path_to_test_data, image_name)
      attach_file 'game_image', prepare_path_for_attachment(path_to_file)
    end
    click_button "game_submit"
    current_path.should match(view_game_page)
    page.should have_content('Game was successfully created.')
    page.should have_content("Title: #{game_title}")
    page.should have_content("Description: #{game_desc}")
    page.should have_xpath("//img[contains(@src,'#{image_name}')]")
    visit homepage
    page.should have_content(game_title)
    click_link(game_title)
    current_path.should match(view_game_page)
  end

  scenario "Set all valid data but do not save game" do
    visit homepage
    click_link('New Game')
    game_title = "Test game #{serial_gen} title"
    game_desc = "Test game #{serial_gen} description"
    image_name = 'poker_cards.jpg'
    within("//form[@id='new_game']") do
      fill_in 'game_title', :with => game_title
      fill_in 'game_description', :with => game_desc
      path_to_file = File.join(get_path_to_test_data, image_name)
      attach_file 'game_image', prepare_path_for_attachment(path_to_file)
    end
    click_link "Back"
    current_path.should == games_page
    page.should have_no_content(game_title)
  end

  #Todo requirement are not known
  scenario "Create game with invalid attachment"
  scenario "Test limit size for title and description"

end
