require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    expect(page).to have_content("Github")
    within('.repos') do
      save_and_open_page
      expect(page).to have_link("adopt_dont_shop_2001")
      expect(page).to have_link("b2-mid-mod")
      expect(page).to have_link("backend_module_0_capstone")
      expect(page).to have_link("battleship")
      expect(page).to have_link("best_animals")
    end

  end
end

#   As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
#  API call uses: https://developer.github.com/v3/repos/#list-your-repositories
#  API call DOES NOT use: https://developer.github.com/v3/repos/#list-user-repositories
#  No hashes in the view.
#  Uses objects in the view to represent the Repos.
#  Edge case: Make sure this shows the proper repositories when there are more than one user in the database with different tokens.
#  Don't display the "Github" section if the user is missing a Github token
