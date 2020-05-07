require 'rails_helper'

describe 'A registered user' do
  it 'can add see their repos on dashboard' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    expect(page).to have_content("Github")
    within('.repos') do
      expect(page).to have_link("adopt_dont_shop_2001")
      expect(page).to have_link("b2-mid-mod")
      expect(page).to have_link("backend_module_0_capstone")
      expect(page).to have_link("battleship")
      expect(page).to have_link("best_animals")
    end
  end
end
