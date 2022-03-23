class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :note
      t.datetime :last_posted_at
      t.boolean :archived, null: false, default: false
      t.datetime :archived_at

      t.timestamps
    end
  end
end
