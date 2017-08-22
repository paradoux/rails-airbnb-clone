class RemoveNameFromArticles < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :name, :string
  end
end
