class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :alpha_sort, -> { order(:name) }
end
