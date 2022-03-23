class Asset
  class Tag
    # This model hold the association of Tags and Taggables (aka Assets)
    class Tagging < ApplicationRecord
      self.table_name = 'asset_tag_taggings'

      belongs_to :tag
      belongs_to :taggable, polymorphic: true

      validates :tag, :taggable, presence: true
    end
  end
end
