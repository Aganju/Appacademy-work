class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :band
      t.string :live

      t.timestamps
    end
    add_index :albums, :name
  end
end
