class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.alpha_sort
    self.order(:name)
  end 
end
