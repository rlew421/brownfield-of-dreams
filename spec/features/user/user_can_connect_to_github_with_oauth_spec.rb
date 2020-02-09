require 'rails_helper'

feature "user can connect to github with oauth" do
  scenario "by clicking a button that connects to Github", :vcr do
    OmniAuth.config.test_mode = true

    user = create(:user)

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :credentials => {:token => ENV['GITHUB_TOKEN']}
      })

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_link("Connect to Github")

    expect(page).to_not have_css(".repositories")
    expect(page).to_not have_css(".followers")
    expect(page).to_not have_css(".following")

    click_link "Connect to Github"
    expect(current_path).to eq('/dashboard')
    expect(page).to have_css(".repositories")
    expect(page).to have_css(".followers")
    expect(page).to have_css(".following")

    expect(user.token).to eq(ENV['GITHUB_TOKEN'])
    OmniAuth.config.mock_auth[:github] = nil
  end
end
