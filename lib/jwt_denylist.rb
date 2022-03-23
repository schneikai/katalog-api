class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  # TODO: How do we expire tokes?

  self.table_name = 'jwt_denylist'
end
