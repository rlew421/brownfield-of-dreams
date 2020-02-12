require 'rails_helper'

feature "user can invite a following or follower to the app if they have an email with Github" do
  scenario "by clicking a link that sends their following or follower or an email", :vcr do
    OmniAuth.config.test_mode = true

    user = create(:user, token: ENV['GITHUB_TOKEN'])
    following_user = Following.new(id: 1, login: "philjdelong", html: "https://github.com/philjdelong")

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :credentials => {:token => user.token}
      })

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(current_path).to eq('/dashboard')

    click_link("Send an Invite")

    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: "philjdelong"
    click_on "Submit"

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Successfully sent invite!")

    visit('/dashboard')
    click_link("Send an Invite")

    fill_in :github_handle, with: "Capleugh"
    click_on "Submit"

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")

    OmniAuth.config.mock_auth[:github] = nil
  end
end
