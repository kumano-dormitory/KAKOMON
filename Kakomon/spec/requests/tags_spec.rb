require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe 'ステータスコードチェック' do
    let!(:past_question) do
      exam_date = ExamDate.create(year: rand(2011..2015), term: ['前期', '後期'].sample)
      create(:past_question, exam_date_id: exam_date.id)
    end
    let!(:tag) do
      Tag.create(name: "tag_1", lock: false)
    end

    before do
      login Member.create(name: 'some_user_name', password: 'some_password', password_confirmation: 'some_password', access_authority: 3)
    end

    it 'index' do
      get tags_path

      expect(response).to have_http_status(:ok)
    end

    it 'show' do
      get (tag_path id: tag.id)

      expect(response).to have_http_status(:ok)
    end

    it 'set_tag' do
      post (set_tag_past_question_tags_path past_question_id: past_question.id), { name: 'tag_name' }

      expect(response).to have_http_status(:see_other)
    end
  end
end
