require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#destroy' do
    context '他人のコメント' do
      it 'returns 403' do
        user = create(:user)
        other_user = create(:user)
        comment = create(:comment, user: other_user)
        sign_in user
        delete :destroy, article_id: comment.article, id: comment
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
