require 'rails_helper'

feature "user can friend a Github following that also exists in our database" do
  scenario "by clicking a link next to their name", :vcr do
    OmniAuth.config.test_mode = true

    user_1 = create(:user, token: ENV['GITHUB_TOKEN'])
    user_2 = create(:user, github_login: "philjdelong")

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :credentials => {:token => user_1.token}
      })

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/dashboard'

    expect(current_path).to eq('/dashboard')

    within(".following") do
      click_link("Add Friend")
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Successfully added friend!")
    expect(user_1.friendships.count).to eq(1)

    OmniAuth.config.mock_auth[:github] = nil
  end
end
