# A Asset is a collection of files. Usually the master file (like the main movie)
# and associated teaser videos, clips and stills.
class Asset < ApplicationRecord
  # strip_attributes

  belongs_to :user
  has_many :files

  has_many :taggings, as: :taggable, class_name: 'Asset::Tag::Tagging'
  has_many :tags, through: :taggings

  validates :user, presence: true

  before_save :set_archived_at, if: :archived_changed?

  def title_with_fallback
    self[:title] || (persisted? && "Asset #{id}")
  end

  # TODO: Have to think how I deal with the NULL/"" in database problem
  # use # gem "strip_attributes"?
  # add something that overwrites model setters?
  # do not allow NULL in DB via migration default ""?
  def title=(value)
    super value.strip.presence
  end

  private

  def set_archived_at
    self.archived_at = (archived? ? Time.now : nil)
  end
end
