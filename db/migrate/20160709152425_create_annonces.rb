class CreateAnnonces < ActiveRecord::Migration
  def change
    create_table :annonces do |t|
      t.string :title
      t.text :description
      t.string :city
      t.string :price
      t.string :phone

      t.timestamps null: false
    end
  end
end
