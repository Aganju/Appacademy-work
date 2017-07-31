class AddIndices < ActiveRecord::Migration[5.0]
  def change
    add_index :albums, :band
    add_index :bands, :name
    add_column :tracks, :album, :string
  end
end
