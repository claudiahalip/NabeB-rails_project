class Business < ApplicationRecord
  belongs_to :neighborhood
  belongs_to :category
end