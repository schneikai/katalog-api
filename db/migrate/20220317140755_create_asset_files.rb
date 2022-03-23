class CreateAssetFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :asset_files do |t|
      t.string :title
      t.text :note
      t.string :type, null: false
      t.references :asset, null: false, foreign_key: true

      t.timestamps
    end
  end
end
