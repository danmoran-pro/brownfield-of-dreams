require 'rails_helper'

describe GithubService do
  context 'instance methods' do
    context '#grab_repos' do
      it "returns repos" do
        github = GithubService.new
        repos = github.grab_repos
        expect(repos).to be_a Array
        repo1 = repos.first
        # expect(repo1.name).to exists
      end
    end

    context '#grab_followers' do
      it "returns followers" do
      end
    end

    context '#grab_following' do
      it "returns following" do
      end
    end

  end
end
