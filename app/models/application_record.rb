class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include ActsAsCsv
end
