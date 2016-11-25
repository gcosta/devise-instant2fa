require 'devise_instant2fa/hooks/instant2fa_authenticatable'

module Devise
  module Models
    module Instant2faAuthenticatable
      def instant2fa_settings_url
        Instant2fa.create_settings(self.id.to_s)
      end

      def with_instant2fa_verification_url
        begin
          hosted_page_url = Instant2fa.create_verification(self.id.to_s)
          return hosted_page_url
        rescue Instant2fa::Errors::MFANotEnabled
        end

        return false
      end
    end
  end
end
