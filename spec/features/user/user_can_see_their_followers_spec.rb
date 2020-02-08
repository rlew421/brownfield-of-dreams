require 'rails_helper'

feature "user can see their followers" do
  scenario "by visiting their dashboard and can click link to visit each follower page", :vcr do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within(".Github") do
      expect(page).to have_css(".followers")
    end

    within(".followers") do
      expect(page).to have_css("#follower", count: 4)
      expect(page).to have_link("Capleugh")
    end
  end
end
