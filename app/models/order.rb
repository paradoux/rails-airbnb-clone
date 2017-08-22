class Order < ApplicationRecord
  belongs_to :user
  belongs_to :article

  enum status: [:en_cours,  :a_preparer, :confirme, :livre,  :annulle]
  # 1. acheteur cree order => en_cours
  # 2. acheteur confirme order => :a_preparer
  # 3. vendeur confirme preparation => :confirme
  # 4. acheteur confirme pickup => :livre
  # 5. vendeur, acheteur ont la possibilité d'annuler l'order

  def confirme_order
    # acheteur confirme order --> order passe du statut en_cours à a_preparer
    @order = Order.find(params[:id])
    @order.status = :a_preparer
    # retour à la page des achats
    redirect_to my_orders_path
  end
end
