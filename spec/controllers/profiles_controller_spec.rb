require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe '#edit' do
    context 'profileが存在しない場合' do
      it 'editがrenderされること' do
        user = create(:user)
        sign_in user
        get :edit
        expect(response).to render_template :edit
      end
    end

    context 'profileが存在する場合' do
      it '正しいprofileが読み出されること' do
        profile = create(:profile)
        sign_in profile.user
        get :edit
        expect(response).to render_template :edit
        expect(assigns(:profile)).to eq profile
      end
    end
  end
end
