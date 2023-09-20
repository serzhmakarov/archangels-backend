# Be sure to restart your server when you modify this file.
# Read more: https://github.com/cyu/rack-cors

# TODO: Don't forget update for production (origins: "*") to https://www.archangels.in.ua

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "https://www.archangels.in.ua"
    resource "*",
      headers: :any,
      expose: ['Authorization'],
      methods: [:get, :patch, :update, :put, :delete, :post, :options, :show]
  end
end
