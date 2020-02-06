require 'rails_helper'

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo

feature "user can see their repositories" do
  scenario "by visiting their dashboard and seeing a section that lists their repositories", :vcr do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within(".Github") do
      expect(page).to have_css(".repositories", count: 30)
    end
  end
end
