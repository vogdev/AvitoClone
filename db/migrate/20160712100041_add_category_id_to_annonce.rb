class AddCategoryIdToAnnonce < ActiveRecord::Migration
  def change
    add_column :annonces, :category_id, :integer
  end
end
