require 'rails_helper'

RSpec.describe Repo, type: :model do
  it "exists" do
    attrs = {name: "Brownfield of Dreams",
            url: "https://github.com/margoflewelling/brownfield-of-dreams"

          }

    repo = Repo.new(attrs[:name], attrs[:url])
    expect(repo).to be_a Repo
    expect(repo.name).to eq("Brownfield of Dreams")
    expect(repo.url).to eq("https://github.com/margoflewelling/brownfield-of-dreams")
  end

end
