require 'rails_helper'
WebMock.allow_net_connect!

describe 'As an admin' do
  it 'can add an entire youtube playlist' do
    # json_response = File.read('spec/fixtures/youtube_playlist.json')
    # stub_request(:get, 'https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails&playlistId=PLLFBEGPiMBa5vYxUKkRJ1KpcQH4rL6v0m&key=AIzaSyDNardOv4hyEXZLPf0lf496lVMLxt4bFio').
    #      to_return(status: 200, body: json_response, headers: {})
    #

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

  it "will not create a tutorial if fields are left blank" do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/admin/tutorials/new"
    expect(page).to have_link("Import Youtube Playlist")
    click_on("Import Youtube Playlist")
    fill_in "tutorial[title]", with: ""
    fill_in "tutorial[description]", with: ""
    fill_in "tutorial[thumbnail]", with: "https://upload.wikimedia.org/wikipedia/en/d/d0/Alt-J_-_An_Awesome_Wave.png"
    fill_in "tutorial[playlist_id]", with: "PLLFBEGPiMBa5vYxUKkRJ1KpcQH4rL6v0m"
    click_on("Save")
    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Tutorial not created - Videos tutorial can't be blank, Title can't be blank, and Description can't be blank")
  end

  it "can import a playlist with more than 50 videos" do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/admin/tutorials/new"
    expect(page).to have_link("Import Youtube Playlist")
    click_on("Import Youtube Playlist")
    fill_in "tutorial[title]", with: "Head and the Heart"
    fill_in "tutorial[description]", with: "top tracks"
    fill_in "tutorial[thumbnail]", with: "https://upload.wikimedia.org/wikipedia/en/d/d0/Alt-J_-_An_Awesome_Wave.png"
    fill_in "tutorial[playlist_id]", with: "PLY4gRtK2vPT0p8S7BgOryVdftBksqqSYX"
    click_on("Save")
    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Successfully created tutorial. View it here.")
    expect(page).to have_link("View it here.")
    click_on("View it here.")
    tutorial = Tutorial.last
    expect(current_path).to eq("/tutorials/#{tutorial.id}")
    expect(page).to have_content("Honeybee")
    expect(tutorial.videos.count).to eq(60)
  end


end
