require "rails_helper"

describe Follower do
  it "exists" do
    attrs = {
      login: "Capleugh",
      html_url: "https://github.com/Capleugh"
    }

    following = Follower.new(attrs)

    expect(following).to be_a Follower
    expect(following.login).to eq("Capleugh")
    expect(following.html_url).to eq("https://github.com/Capleugh")
  end
end
