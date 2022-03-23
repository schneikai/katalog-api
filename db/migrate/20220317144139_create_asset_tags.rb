class CreateAssetTags < ActiveRecord::Migration[7.0]
  def change
    create_table :asset_tags do |t|
      t.string :text, null: false

      t.timestamps
    end
  end
end
