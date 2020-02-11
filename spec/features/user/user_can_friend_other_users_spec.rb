require 'rails_helper'

feature "user can friend a Github following that also exists in our database" do
  scenario "by clicking a link next to their name", :vcr do
    OmniAuth.config.test_mode = true

    # user whose dashboard we're visiting
    user_1 = create(:user, email: "rlew07@gmail.com")

    # user_1 is following user_2, should be able to click a link to friend them
    user_2 = create(:user, email: "philjdelong@gmail.com")

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :credentials => {:token => ENV['GITHUB_TOKEN']}
      })

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/dashboard'

    click_link "Connect to Github"

    expect(current_path).to eq('/dashboard')

    within(first("#following_user")) do
      click_link("Add Friend")
    end

    expect(current_path).to eq('/dashboard')

    OmniAuth.config.mock_auth[:github] = nil
  end
end
