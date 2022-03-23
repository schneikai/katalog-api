# Patch that prevents devise from returning a user from the session if token auth is used
# See README "Warden Devise JWT Sessions Patch" for more info

require 'warden'

module WardenProxyExtension
  def user(argument = {})
    return nil if request.format.json?

    super
  end
end

module Warden
  class Proxy
    prepend ::WardenProxyExtension
  end
end
