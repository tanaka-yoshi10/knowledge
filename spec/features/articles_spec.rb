require 'rails_helper'

feature 'Articles' do
  scenario 'show article' do
    user = create(:user)
    article = create(:article, user: user)

    visit article_path(article)
    expect(page).to have_content 'MyString'
  end
end