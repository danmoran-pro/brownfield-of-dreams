require 'rails_helper'

describe 'As an admin' do
  xit 'can add an entire youtube playlist' do
    json_response_repos = File.read('spec/fixtures/youtube_playlist.json')

    stub_request(:get, "https://www.googleapis.com/youtube/v3/playlistItems?&maxResults=50&part=contentDetails&playlistId=PLLFBEGPiMBa5vYxUKkRJ1KpcQH4rL6v0m").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v1.0.1'
      }).
    to_return(status: 200, body: "json_response_repos", headers: {})

    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    expect(page).to have_link("Import Youtube Playlist")
    click_on("Import Youtube Playlist")
    fill_in "tutorial[title]", with: "alt J"
    fill_in "tutorial[description]", with: "An Awesome Wave Album"
    fill_in "tutorial[thumbnail]", with: "https://upload.wikimedia.org/wikipedia/en/d/d0/Alt-J_-_An_Awesome_Wave.png"
    fill_in "tutorial[playlist_id]", with: "PLLFBEGPiMBa5vYxUKkRJ1KpcQH4rL6v0m"
    click_on("Save")
    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Successfully created tutorial. View it here.")
    expect(page).to have_link("View it here.")
    click_on("View it here.")
    tutorial = Tutorial.last
    expect(current_path).to eq("/tutorials/#{tutorial.id}")
    within(first('.video')) do
      expect(page).to have_content("Intro")
    end
    expect(tutorial.videos.count).to eq(14)
  end
end

# As an admin
# When I visit '/admin/tutorials/new'
# Then I should see a link for 'Import YouTube Playlist'
# When I click 'Import YouTube Playlist'
# Then I should see a form
#
# And when I fill in 'Playlist ID' with a valid ID
# Then I should be on '/admin/dashboard'
# And I should see a flash message that says 'Successfully created tutorial. View it here.'
# And 'View it here' should be a link to '/tutorials/:id'
# And when I click on 'View it here'
# Then I should be on '/tutorials/:id'
# And I should see all videos from the YouTube playlist
# And the order should be the same as it was on YouTube
