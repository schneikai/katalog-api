FactoryBot.define do
  factory :asset_file, class: 'Asset::File' do
    asset

    trait :photo do
      title { 'Still Image' }
      type { 'image' }
    end

    trait :video do
      title { 'Teaser Video' }
      type { 'video' }
    end
  end
end
