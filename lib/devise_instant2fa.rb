require 'devise_instant2fa/version'
require 'devise'
require 'active_support/concern'
require 'active_support/core_ext/class/attribute_accessors'
require 'instant2fa'

module Devise

  @@instant2fa_access_key = nil
  def self.instant2fa_access_key
    @@instant2fa_access_key
  end

  def self.instant2fa_access_key=(instant2fa_access_key)
    @@instant2fa_access_key = @@instant2fa_access_key
    Instant2fa.configure do |config|
      config.access_key = instant2fa_access_key
    end
  end

  @@instant2fa_access_secret = nil
  def self.instant2fa_access_secret
    @@instant2fa_access_secret
  end

  def self.instant2fa_access_secret=(instant2fa_access_secret)
    @@instant2fa_access_secret = @@instant2fa_access_secret
    Instant2fa.configure do |config|
      config.access_secret = instant2fa_access_secret
    end
  end
end

module DeviseInstant2fa
  NEED_AUTHENTICATION = 'need_two_factor_authentication'
  HOSTED_PAGE_URL = 'hosted_page_url'

  autoload :Mapping, 'devise_instant2fa/mapping'

  module Controllers
    autoload :Passwords, 'devise_instant2fa/controllers/passwords'
    autoload :Helpers, 'devise_instant2fa/controllers/helpers'
  end

  module Views
    autoload :Helpers, 'devise_instant2fa/views/helpers'
  end
end

require 'devise_instant2fa/routes'
require 'devise_instant2fa/rails'
require 'devise_instant2fa/models/instant2fa_authenticatable'

Devise.add_module :instant2fa_authenticatable, :controller => :instant2fa, :route => :instant2fa

