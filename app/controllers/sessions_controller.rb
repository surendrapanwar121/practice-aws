class SessionsController < ApplicationController
  def new
    session[:user_id] = nil if current_user
    # @user = User.new
    @serialized_user = serialized_session_fields
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      render json: { message: 'Login Successfull!!', error: nil, redirect_link: '/' }
      # flash[:notice] = 'Login Successfull!!'
      # redirect_to root_path
    else
      render json: { message: nil, errors: ['Login Failed!!'], redirect_link: '/login' }
      # flash[:error] = 'Login Failed!!'
      # render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def serialized_session_fields
    ##improve
    [{ field_name: :email, field_type: :email }, { field_name: :password, field_type: :password }]
  end
end
