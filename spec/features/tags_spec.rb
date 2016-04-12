require 'rails_helper'

feature 'Tags' do
  scenario 'show tag' do
    user = create(:user)
    article = create(:article, author: user)

    visit root_path
    fill_in '名前', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit edit_article_path(article)
    fill_in 'Tag list', with: "iOS"
    click_button '更新する'

    visit tag_path("iOS")
    expect(page).to have_content 'MyString'
  end

  scenario 'invalid tag' do
    visit '/tags/aab'
    expect(page.status_code).to eq 404
  end
end
