class Article < ApplicationRecord

  has_attachment :photo
  belongs_to :user
  has_many :orders, dependent: :destroy
  validates :name, :quantity, :price, :unit, presence: true

  enum active: [:inactif, :actif]

  def self.units
    ["kg", "g", "unités", "l"]
  end
end
