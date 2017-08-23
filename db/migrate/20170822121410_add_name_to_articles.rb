class AddNameToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :name, :text
  end
end
