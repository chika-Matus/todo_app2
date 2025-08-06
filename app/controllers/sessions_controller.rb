# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    # 既にログインしている場合はTODO一覧にリダイレクト
    if logged_in?
      redirect_to todos_path
    end
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました"
      redirect_to todos_path
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end
end