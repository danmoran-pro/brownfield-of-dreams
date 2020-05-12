require 'rails_helper'

describe 'A registered user' do
  it 'can add see their repos on dashboard' do
    
    json_response_repos = File.read('spec/fixtures/repos.json')
    json_response_followers = File.read('spec/fixtures/followers.json')
    json_response_following = File.read('spec/fixtures/following.json')
    stub_request(:get, 'https://api.github.com/user/repos?page=1&per_page=5').to_return(status: 200, body: json_response_repos)
    stub_request(:get, 'https://api.github.com/user/followers').to_return(status: 200, body: json_response_followers)
    stub_request(:get, 'https://api.github.com/user/following').to_return(status: 200, body: json_response_following)

    user = create(:user, github_token:  ENV['GITHUB_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    
    expect(page).to have_content("Repos")
    within('.repos') do
      expect(page).to have_link("adopt_dont_shop_2001")
      expect(page).to have_link("b2-mid-mod")
      expect(page).to have_link("backend_module_0_capstone")
      expect(page).to have_link("battleship")
      expect(page).to have_link("futbol")
    end
  end
end
