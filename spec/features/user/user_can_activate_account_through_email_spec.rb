require 'rails_helper'

feature "when I register as a user, my account is not yet active" do
  scenario "but I can activate my account through an email that is sent to me" do
    visit "/"

    click_link "Register"

    expect(current_path).to eq('/register')

    email = "rlew07@gmail.com"
    first_name = "Rachel"
    last_name = "Lew"
    password = "password"
    password_confirmation = "password"

    fill_in "user_email", with: email
    fill_in "user_first_name", with: first_name
    fill_in "user_last_name", with: last_name
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password

    click_button "Create Account"

    user = User.last

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as Rachel Lew")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")

    click_link "Activate Your Account"

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Thank you! Your account is now activated.")
    expect(user.activated?).to eq(true)
    expect(page).to have_content("Status: Active")
  end
end

# As a guest user
# When I visit "/"
# And I click "Register"
# Then I should be on "/register"
# And when I fill in an email address (required)
# And I fill in first name (required)
# And I fill in last name (required)
# And I fill in password and password confirmation (required)
# And I click submit
# Then I should be redirected to "/dashboard"
# And I should see a message that says "Logged in as <SOME_NAME>"
# And I should see a message that says "This account has not yet been activated. Please check your email."
# Background: The registration process above will trigger this story
#
# As a non-activated user
# When I check my email for the registration email
# I should see a message that says "Visit here to activate your account."
# And when I click on that link
# Then I should be taken to a page that says "Thank you! Your account is now activated."
#
# And when I visit "/dashboard"
# Then I should see "Status: Active"
