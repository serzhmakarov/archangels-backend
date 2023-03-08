# frozen_string_literal: true
# class FailureApp < Devise::FailureApp
#   def json_error_response
#     self.status = 401
#     self.content_type = "application/json"
#     self.response_body = { status: { code: 401, message: "Invalid email or password." } }.to_json
#   end
#   def failure
#     self.status = :unauthorized
#     self.content_type = "application/json"
#     self.response_body = { status: { code: 401, message: "Invalid email or password." } }.to_json
#   end
# end

Devise.setup do |config|
  # config.secret_key = '5d17714294f999d47f7f08b6c40765eac8938f4ebf0fc3393b70fecbcd2fdc6daaae1949c71d593bd064ceaee2ca640f43bc8ec41a66b487cc9dd4ac99588ac3'
  # config.parent_controller = 'DeviseController'
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.authentication_keys = [:email]
  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  # config.params_authenticatable = true

  # config.http_authenticatable = false

  # config.http_authenticatable_on_xhr = true

  # config.http_authentication_realm = 'Application'

  config.warden do |manager|
    manager.failure_app = Users::SessionsController.action(:failure)
  end
  
  # Does not affect registerable.
  config.paranoid = true

  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.navigational_formats = []
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.fetch(:secret_key_base)
    jwt.dispatch_requests = [
      ['POST', %r{^/login$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/logout$}]
    ]
    jwt.expiration_time = 30.minutes.to_i
  end
end
