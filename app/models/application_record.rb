class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include ActsAsCsv

  def current_controller
    Thread.current[:current_controller]
  end

  def current_account
    current_controller.send(:current_account)
  end

  def current_user
    current_controller.send(:current_user)
  end
end
