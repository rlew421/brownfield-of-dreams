require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#user_repositories" do
      it "returns a user's repos", :vcr do
        service = GithubService.new("#{ENV['GITHUB_TOKEN']}")
        search = service.user_repositories
        expect(search.count).to eq(30)
      end

      it "returns a user's followers", :vcr do
        service = GithubService.new("#{ENV['GITHUB_TOKEN']}")
        search = service.user_followers
        expect(search.count).to eq(5)
      end

      it "returns the users a user is following", :vcr do
        service = GithubService.new("#{ENV['GITHUB_TOKEN']}")
        search = service.user_following
        expect(search.count).to eq(7)
      end
    end
  end
end
