require 'rails_helper'

feature "user can see the users they are following" do
  scenario "by visiting their dashboard and seeing a section that lists the users they are following as links to those profiles", :vcr do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within(".Github") do
      expect(page).to have_css(".following")
    end

    within(".following") do
      expect(page).to have_link("philjdelong")
      expect(page).to have_link("Capleugh")
    end
  end
end
