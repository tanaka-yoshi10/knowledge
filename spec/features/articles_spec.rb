require 'rails_helper'

feature 'Articles' do
  scenario 'show article' do
    article = create(:article)

    visit article_path(article)
    expect(page).to have_content 'MyString'
  end
end