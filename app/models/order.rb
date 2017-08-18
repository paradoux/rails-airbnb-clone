class Order < ApplicationRecord
  belongs_to :user
  belongs_to :article

  enum status: [:en_cours, :confirme, :a_preparer, :livre, :annulle]
end
