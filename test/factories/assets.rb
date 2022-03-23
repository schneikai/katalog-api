FactoryBot.define do
  factory :asset do
    user
    title { Faker::Movie.title }
  end
end
