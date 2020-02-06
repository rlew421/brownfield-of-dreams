require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#user_repositories" do
      it "returns a user's repos", :vcr do
        search = subject.user_repositories
        expect(search.count).to eq(30)
      end
    end
  end
end
