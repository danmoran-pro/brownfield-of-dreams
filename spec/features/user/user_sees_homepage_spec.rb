require 'rails_helper'

describe 'User' do
  describe 'on the home page' do
    it "can see tutorials with classroom content" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      tutorial1 = create(:tutorial)
      tutorial3 = create(:tutorial)
      tutorial3.classroom = true
      tutorial3.save

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial3.id)
      video4 = create(:video, tutorial_id: tutorial3.id)

      visit root_path
      expect(page).to have_content(tutorial1.title)
      expect(page).to have_content(tutorial1.description)
      expect(page).to have_content(tutorial3.title)
      expect(page).to have_content(tutorial3.description)
    end
  end
end
