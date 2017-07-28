class ChangeColumns < ActiveRecord::Migration[5.0]
  def change
    remove_index :albums, :band

    remove_column :albums, :band
    remove_column :tracks, :album

    add_column :albums, :band_id, :integer
    add_column :tracks, :album_id, :integer

    add_index :albums, :band_id
    add_index :tracks, :album_id
  end
end
