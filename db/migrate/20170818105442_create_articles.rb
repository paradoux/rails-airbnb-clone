class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :unit
      t.string :description
      t.string :image
      t.date :delivery_date
      t.integer :price
      t.integer :quantity
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
