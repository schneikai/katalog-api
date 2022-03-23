# TODO: Lock this down!

# From devise-jwt Example
# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'http://your.frontend.domain.com'
#     resource '/api/*',
#       headers: %w(Authorization),
#       methods: :any,
#       expose: %w(Authorization),
#       max_age: 600
#   end
# end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[Authorization]
  end
end
