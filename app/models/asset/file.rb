class Asset
  # A file is a photo or a video associated with a Asset
  class File < ApplicationRecord
    self.table_name = 'asset_files'
    self.inheritance_column = nil

    TYPES = %i[image video].freeze

    belongs_to :asset

    validates :asset, presence: true
    validates :type, inclusion: { in: TYPES }
  end
end
