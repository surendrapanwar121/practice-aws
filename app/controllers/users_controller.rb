class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :enable, :disable]

  def index
    @users = current_account.users.all_users
  end

  def show
    user = current_account.users.find(params[:id])
    render json: user
  end

  def new
    @user = current_account.users.new
  end


  def create
    ActiveRecord::Base.transaction do
      @user = current_account.users.new(user_params)
      @user.save!
      @user.user_roles.create!(user_role_params.merge!(account: current_account)) unless current_account.is_a?(LegacyAccount)
      flash[:notice] = "User created successfully"
      redirect_to users_path
    rescue => e
      puts "#{e.message}"
      render :new, status: :unprocessable_entity
      raise ActiveRecord::Rollback
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def enable
    @user.update(disabled: false)
    redirect_to users_path, notice: 'User was successfully enabled.'
  end

  def disable
    ## Todo, add check for last admin and also add error handling
    @user.update(disabled: true)
    redirect_to users_path, notice: 'User was successfully disabled.'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :account_id, :role_id)
  end

  def user_role_params
    params.require(:user).require(:user_roles).permit(:role_id)
  end

  def find_user
    @user = current_account.users.find params[:id]
  rescue ActiveRecord::RecordNotFound
    redirect_to users_path, alert: 'User not found.'
  end
end
