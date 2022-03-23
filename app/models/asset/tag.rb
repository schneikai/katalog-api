class Asset
  # Allows to Tag Assets
  class Tag < ApplicationRecord
    self.table_name = 'asset_tags'

    validates :text, presence: true
  end
end
