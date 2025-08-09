# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :require_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "アカウントが作成されました"
      redirect_to todos_path
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_update_params)
      flash[:notice] = "プロフィールが更新されました"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
  def user_update_params
    params.require(:user).permit(:name, :email)
  end
  
  def require_same_user
    if current_user != User.find(params[:id])
      flash[:alert] = "他のユーザーの情報は編集できません"
      redirect_to todos_path
    end
  end
end