require 'rails_helper'

describe "As a registered user" do
    it 'can add see bookmarked videos on dashboard' do

      user = create(:user, github_token:  ENV['GITHUB_TOKEN'])
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)
      bookmark1 = UserVideo.new(user.id, video2.id)
      bookmark2 = UserVideo.new(user.id, video1.id)
      bookmark3 = UserVideo.new(user.id, video4.id)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
      expect(page).to have_content("Bookmarked videos")

      within(".#{tutorial1.name}") do
        within(first(".video")) do
          expect(page).to have_content(video2.name)
        end
        expect(page).to have_content(video1.name)
      end
      within (".#{tutorial2.name}") do
        expect(page).to have_content(video4.id)
      end

  end
end


# As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked
# Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position
