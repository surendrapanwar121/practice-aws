class SessionsController < ApplicationController
  def new
    session[:user_id] = nil if current_user
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:notice] = 'Login Successfull!!'
      redirect_to root_path
    else
      flash[:error] = 'Login Failed!!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
