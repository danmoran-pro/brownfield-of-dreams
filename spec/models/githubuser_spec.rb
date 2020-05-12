require 'rails_helper'

RSpec.describe GithubUser, type: :model do
  it "exists" do
    attrs = {name: 'Daniel "Danny" Moran',
            url: "https://github.com/danmoran-pro"

          }

    user = GithubUser.new(attrs[:name], attrs[:url])
    expect(user).to be_a GithubUser
    expect(user.name).to eq('Daniel "Danny" Moran')
    expect(user.url).to eq("https://github.com/danmoran-pro")
  end

end
