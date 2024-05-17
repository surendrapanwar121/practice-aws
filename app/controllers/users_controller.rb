class UsersController < ApplicationController
  def index
    @users = User.all_users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User created successfully"
      redirect_to users_path
    else
      flash[:alert] = "User not created"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :account_id, :role_id)
  end
end
