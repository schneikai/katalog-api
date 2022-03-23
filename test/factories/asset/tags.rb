FactoryBot.define do
  factory :asset_tag, class: 'Asset::Tag' do
    text { Faker::Color.color_name }
  end
end
