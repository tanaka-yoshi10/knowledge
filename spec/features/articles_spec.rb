require 'rails_helper'

feature 'Articles' do
  scenario 'show article' do
    article = create(:article)

    visit article_path(article)
    expect(page).to have_content 'MyString'
  end

  scenario 'show drafts' do
    user = create(:user)
    article = create(:article, title: 'Draft', author: user, status: :draft)

    visit root_path
    fill_in '名前', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit drafts_articles_path
    expect(page).to have_content 'Draft'
  end
end