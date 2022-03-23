class CreateAssetTagTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :asset_tag_taggings do |t|
      t.references :taggable, polymorphic: true, null: false
      t.references :tag, null: false, foreign_key: { to_table: :asset_tags }

      t.timestamps
    end
  end
end
