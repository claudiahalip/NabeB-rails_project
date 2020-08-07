class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # def self.alpha_sort
  #   self.order(:name)
  # end 

  scope :alpha_sort, -> { order(:name) }
end
