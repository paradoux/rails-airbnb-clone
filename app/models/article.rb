class Article < ApplicationRecord
  belongs_to :user
  has_many :orders

  enum active: [:inactif, :actif]
end
