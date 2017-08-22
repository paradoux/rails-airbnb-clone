class Order < ApplicationRecord
  after_create :send_order_create_email

  belongs_to :user
  belongs_to :article

  enum status: [:en_cours,  :a_preparer, :confirme, :livre,  :annulle]
  # 1. acheteur cree order => en_cours
  # 2. acheteur confirme order => :a_preparer
  # 3. vendeur confirme preparation => :confirme
  # 4. acheteur confirme pickup => :livre
  # 5. vendeur, acheteur ont la possibilité d'annuler l'order

  private

  def send_order_create_email
    OrderMailer.prepare(self).deliver_now
  end

end
