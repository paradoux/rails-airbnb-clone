class Order < ApplicationRecord
  belongs_to :user
  belongs_to :article

  enum status: [:en_cours,  :a_preparer, :confirme, :livre,  :annulle]
  # 1. création order => en_cours
  # 2. acheteur confirme order => :a_preparer
  # 3. vendeur confirme preparation => :confirme
  # 4. acheteur confirme pickup => :livre
  # 4. vendeur, acheteur ont la possibilité d'annuler l'order
end
