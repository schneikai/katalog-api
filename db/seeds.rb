# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

include FactoryBot::Syntax::Methods # rubocop:disable Style/MixinUsage

admin = create(:user, email: 'admin@katalog.io', password: '123456', is_admin: true)
user = create(:user, email: 'user@katalog.io', password: '123456')

asset1 = create(:asset, user: user, note: Faker::Movie.quote, last_posted_at: 3.days.ago)
asset2 = create(:asset, user: user)
asset3 = create(:asset, user: user, archived: true, last_posted_at: 7.days.ago)
