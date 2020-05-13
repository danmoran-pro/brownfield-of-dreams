require 'rails_helper'
WebMock.allow_net_connect!

describe "As a registered user" do

    it 'can add friends that are also registered' do
      user = create(:user, github_token:  ENV['GITHUB_TOKEN'], username: "danmoran-pro")
      follower = create(:user, username: "alex-latham")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
      within ('.followers') do
        within(first('.follower')) do
          expect(page).to have_link(follower.username)
          expect(page).to have_button("Add Friend")
          click_on("Add Friend")
        end
      end
      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Added friend")
  end
end

# Details: We want to create friendships between users with accounts in our database.
#  Long term we want to make video recommendations based on what friends are bookmarking.
#  This card should not include the recommendation logic. That's coming in a different user story.
# #
# # Background: A user (Josh) exists in the system with a Github token.
# The user has two followers on Github. One follower (Dione) also has an account
#  within our database. The other follower (Mike) does not have an account in our system.
#  If a follower or following has an account in our system we want to include a
#  link next to their name to allow us to add as a friend.
# #
# # In this case Dione would have an Add as Friend link next to her name.
# Mike would not have the link next to his name.
# #
# #
# #  Links show up next to followers that have accounts in our system.
# #  Links show up next to followings that have accounts in our database.
# #  Links do not show up next to followers or followings if they are not in our database.
# #  There's a section on the dashboard that shows all of the users that I have friended
# #  Edge Case: Make sure this fails gracefully. If you open up a POST route to create a
# friendship, be sure to catch the scenario where someone sends an invalid user id.
# Send a flash message alerting them of the error.
