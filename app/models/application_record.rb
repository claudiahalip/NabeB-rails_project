class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :alpha_sort, -> { order('LOWER(name)') }
end
