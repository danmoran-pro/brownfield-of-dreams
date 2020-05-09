require 'rails_helper'

RSpec.describe Video do
  describe 'relationships' do
    it {should belong_to :tutorial}
    it {should have_many(:users).through(:user_videos)}
    it {should have_many(:user_videos).dependent(:destroy)}
  end
  describe 'validations' do
    it {should validate_presence_of :tutorial_id}
  end
end
