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
      bookmark1 = UserVideo.new({user_id: user.id, video_id: video2.id})
      bookmark1.save
      bookmark2 = UserVideo.new({user_id: user.id, video_id: video1.id})
      bookmark2.save
      bookmark3 = UserVideo.new({user_id: user.id, video_id: video4.id})
      bookmark3.save


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
      expect(page).to have_content("Bookmarked Segments")

      within(first(".tutorial"))do
        within(first(".video")) do
          expect(page).to have_content(video2.title)
        end
        expect(page).to have_content(video1.title)
      end
      expect(page).to have_content(video4.title)

  end
end


# As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked
# Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position
