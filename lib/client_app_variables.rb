module ClientAppVariables
  def self.included(klass)
    klass.before_action do
      if current_user
        set_current_user
        set_current_account
      end
    end
  end

  private
  def set_current_user
    gon.current_user = current_user
  end

  def set_current_account
    gon.current_account = current_account
  end
end