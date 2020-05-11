require 'rails_helper'

describe "As a registered user" do
    xit 'can add see the accounts they  follow on dashboard' do
      user = create(:user)
  
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  
      visit '/dashboard'
      expect(page).to have_content("Github")
     
      within('.following') do
        expect(page).to have_link("StephanieFriend")
        expect(page).to have_link("tylertomlinson")
        expect(page).to have_link("kristastadler")
      end
  end
end