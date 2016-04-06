require 'rails_helper'

feature 'Tags' do
  scenario 'show tag' do
    user = create(:user)
    article = create(:article, author: user)

    visit edit_article_path(article)
    fill_in 'Tag list', with: "iOS"
    click_button '更新する'

    visit tag_path("iOS")
    expect(page).to have_content 'MyString'
  end
end
