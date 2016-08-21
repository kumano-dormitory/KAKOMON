class TagsController < ApplicationController
  before_action :login_required
  before_action :editor_login_required, only: [:untag]

  def index
    @tags = Tag.order("name")
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def untag
    @past_question = PastQuestion.find(params[:past_question_id])
    @past_question.tags.destroy(Tag.find(params[:id]))
    redirect_to @past_question, notice: "タグを削除しました。"
  end
end
