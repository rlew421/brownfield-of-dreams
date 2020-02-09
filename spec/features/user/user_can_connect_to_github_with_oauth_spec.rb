require 'rails_helper'

# This functionality passes other tests and works in development. Need to refactor this test

feature "user can connect to github with oauth" do
  scenario "by clicking a button that connects to Github", :vcr do
    user = create(:user)

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
  end
end
