require "rails_helper"

describe Following do
  it "exists" do
    attrs = {
      login: "philjdelong",
      html_url: "https://github.com/philjdelong"
    }

    following = Following.new(attrs)

    expect(following).to be_a Following
    expect(following.login).to eq("philjdelong")
    expect(following.html_url).to eq("https://github.com/philjdelong")
  end
end
