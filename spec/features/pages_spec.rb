require 'rails_helper'

feature 'Pages' do
  scenario 'show article page' do
    user = create(:user)
    article = create(:article, author: user, status: :published)

    visit root_path
    fill_in '名前', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit articles_path
    expect(page).to have_content 'MyString'
  end

  scenario '下書きは一覧に表示されない' do
    user = create(:user)
    article = create(:article, author: user, status: :draft)

    visit root_path
    fill_in '名前', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit articles_path
    expect(page).not_to have_content 'MyString'
  end
end