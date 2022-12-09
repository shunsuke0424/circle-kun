class UsersController < ApplicationController
  def index
    @users = User.includes(:company).order(updated_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(signup_user_params)
    set_association

    @user.save!
    render :show, status: 201
  rescue StandardError => e
    errors = [e.message]
    render json: { message: 'ユーザーの作成に失敗しました', errors: errors }, status: 400
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(update_user_params)
    set_association

    if @user.save
      render :show, status: 200
    else
      render json: { message: '更新に失敗しました' }, status: 400
    end
  end

  private

  def signup_user_params
    params.permit(:last_name, :first_name, :email)
          .slice(:last_name, :first_name, :email)
  end

  def update_user_params
    user_params = params.permit(:last_name, :first_name) # emailはユーザー自身で更新可能
    user_params
  end

  def set_association
    company = Company.where(id: params[:company_id]).first
    user_company = UserCompany.find_or_initialize_by(user: @user)
    user_company.company = company
    @user.user_company = user_company
  end
end
