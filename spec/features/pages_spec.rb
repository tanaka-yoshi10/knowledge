require 'rails_helper'

feature 'Pages' do
  scenario 'show top page' do
    user = create(:user)
    article = create(:article, author: user)

    visit root_path
    fill_in '名前', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit root_path
    expect(page).to have_content 'MyString'
  end
end