require 'rails_helper'

feature 'Tags' do
  scenario 'show tag' do
    # [review] let を使って書きたいです
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
    # [review] MyStrignが何なのかfactoriesを見ないとわからないです
    # http://qiita.com/jnchito/items/eb3cfa9f7db752dcb796
    expect(page).to have_content 'MyString'
  end

  scenario 'invalid tag' do
    # [review] ↓みたいに書けます
    visit tag_path(name: 'aab')
    # visit '/tags/aab'
    expect(page.status_code).to eq 404
  end
end
