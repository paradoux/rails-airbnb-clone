class Order < ApplicationRecord
  belongs_to :user
  belongs_to :article

  enum status: [:pendding, :confirmed, :to_prepare, :delivered, :cancelled]
end
