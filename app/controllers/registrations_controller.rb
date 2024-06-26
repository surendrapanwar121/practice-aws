class RegistrationsController < ApplicationController
  def new
    @account = Account.new
    @user = @account.users.build
    @subdomain = request.subdomain
  end

  def create
    ActiveRecord::Base.transaction do
      @account = Account.new(account_params)
      @account.save!
      @user = @account.users.build(user_params)
      @user.role = @account.roles.admin
      @user.save!
      @account.owner = @user
      @account.save!
      flash[:notice] = 'Account and user created successfully.'
      redirect_to root_path
    rescue => e
      puts "#{e.message}"
      @all_error_messages = get_all_error_messages
      render :new
      raise ActiveRecord::Rollback
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :country, :subdomain)
  end

  def user_params
    params.require(:account).require(:users).permit(:name, :email, :password, :password_confirmation)
  end

  def get_all_error_messages
    @user ? @account.errors.full_messages + @user.errors.full_messages : @account.errors.full_messages
  end
end
