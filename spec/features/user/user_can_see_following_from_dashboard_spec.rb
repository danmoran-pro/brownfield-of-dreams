require 'rails_helper'

describe "As a registered user" do
    it 'can add see the accounts they  follow on dashboard' do
      json_response_repos = File.read('spec/fixtures/repos.json')
      json_response_followers = File.read('spec/fixtures/followers.json')
      json_response_following = File.read('spec/fixtures/following.json')
      stub_request(:get, 'https://api.github.com/user/repos?page=1&per_page=5').to_return(status: 200, body: json_response_repos)
      stub_request(:get, 'https://api.github.com/user/followers').to_return(status: 200, body: json_response_followers)
      stub_request(:get, 'https://api.github.com/user/following').to_return(status: 200, body: json_response_following)
      
      user = create(:user, github_token:  ENV['GITHUB_TOKEN'])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  
      visit '/dashboard'

      expect(page).to have_content("Following")
     
      within('.following') do
        expect(page).to have_link("StephanieFriend")
        expect(page).to have_link("tylertomlinson")
        expect(page).to have_link("kristastadler")
      end
  end
end