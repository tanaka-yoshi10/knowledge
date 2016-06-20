require 'rails_helper'

feature 'User management' do
  scenario 'signup' do
    visit new_user_registration_path
    fill_in "Email", with: "user@example.com"
    fill_in "名前", with: "Example User"
    fill_in "Password", with: "foobar12"
    fill_in "Password confirmation", with: "foobar12"
    expect do
      click_button "Sign up"
    end.to change(User, :count).by(1)
  end

  scenario 'show user' do
    user = create(:user)
    article = create(:article, author: user, title: "About something")

    visit user_path(user)
    expect(page).to have_content "About something"
  end
end