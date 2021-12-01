class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    enable_extension :pg_trgm
    enable_extension :unaccent

    create_table :recipes do |t|
      t.string :name
      t.string :prep_time
      t.string :cook_time
      t.string :difficulty
      t.string :image
      t.text :ingredients, array: true, default: []
      t.text :tags, array: true, default: []
      t.integer :people_quantity
      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :recipes, :ingredients, using: :gin
  end
end
