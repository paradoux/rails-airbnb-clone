class Order < ApplicationRecord
  after_create :send_order_create_email

  belongs_to :user
  belongs_to :article

  enum status: [:en_cours, :confirme, :a_preparer, :livre, :annulle]

  private

  def send_order_create_email
    OrderMailer.create(self).deliver_now
  end

end
