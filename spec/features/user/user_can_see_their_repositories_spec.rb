require 'rails_helper'

feature "user can see their repositories" do
  scenario "by visiting their dashboard and seeing a section that lists their repositories", :vcr do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within(".Github") do
      expect(page).to have_css(".repositories")
    end

    within(".repositories") do
      expect(page).to have_css("#repository", count: 30)
    end
  end
end
