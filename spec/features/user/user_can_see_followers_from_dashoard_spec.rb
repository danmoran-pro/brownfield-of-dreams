require 'rails_helper'

describe "As a registered user" do
    it 'can add see their followers on dashboard' do
      user = create(:user)
  
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  
      visit '/dashboard'
      expect(page).to have_content("Github")
     
      within('.followers') do
        expect(page).to have_link("danmoran-pro")
        expect(page).to have_link("DavidTTran")
        expect(page).to have_link("alex-latham")
      end
  end
end