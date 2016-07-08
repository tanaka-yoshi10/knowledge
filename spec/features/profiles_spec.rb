require 'rails_helper'

RSpec.feature "Profiles", type: :feature do
  let (:user) { create(:user) }

  scenario 'プロフィール作成と修正' do
    visit root_path
    fill_in '名前', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'プロフィール変更'
    expect(page).to have_content 'Editing profile'

    fill_in 'First name', with: 'First'
    fill_in 'Last name', with: 'Last'
    click_button '登録する'

    expect(page).to have_content 'First Last'

    click_link 'プロフィール変更'
    expect(page).to have_content 'Editing profile'

    fill_in 'First name', with: 'FFFF'
    fill_in 'Last name', with: 'LLLL'
    click_button '更新する'

    expect(page).to have_content 'FFFF LLLL'
  end
end
