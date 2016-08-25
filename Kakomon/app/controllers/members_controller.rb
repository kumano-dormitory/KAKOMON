class MembersController < ApplicationController
  before_action :super_login_required, except: [:index]

  def index
    @members = Member.order(:id)
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
  end

  def edit
    @member = Member.find(params[:id])
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to @member, notice: "メンバーを追加しました。", status: :see_other
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(member_params)
    if @member.save
      redirect_to @member, notice: "メンバーの情報を更新しました。", status: :see_other
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :members, notice: "メンバーを削除しました。", status: :see_other
  end

  def member_params
    attrs = [:name, :password, :password_confirmation]
    attrs << :access_authority
    params.require(:member).permit(attrs)
  end
end
