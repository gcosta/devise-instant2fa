module DeviseInstant2fa
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        before_action :handle_two_factor_authentication, :if => :is_signing_in?
      end

      def is_devise_sessions_controller?
        self.class == Devise::SessionsController || self.class.ancestors.include?(Devise::SessionsController)
      end

      def is_signing_in?
        if devise_controller? && signed_in?(resource_name) &&
           is_devise_sessions_controller? &&
           self.action_name == "create"
          return true
        end

        return false
      end

      private

      def handle_two_factor_authentication
        Devise.mappings.keys.flatten.any? do |scope|
          if signed_in?(scope) and warden.session(scope)[DeviseInstant2fa::NEED_AUTHENTICATION]
            check_request_and_redirect_to_verify(scope)
          end
        end
      end

      def check_request_and_redirect_to_verify(scope)
        id = warden.session(resource_name)[:id]
        hosted_page_url = warden.session(resource_name)[DeviseInstant2fa::HOSTED_PAGE_URL]

        remember_me = (params.fetch(resource_name, {})[:remember_me].to_s == "1")
        return_to = session["#{resource_name}_return_to"]
        warden.logout
        warden.reset_session! # make sure the session reset

        session["#{resource_name}_id"] = id
        session["#{resource_name}_hosted_page_url"] = hosted_page_url
        # this is safe to put in the session because the cookie is signed
        session["#{resource_name}_password_checked"] = true
        session["#{resource_name}_remember_me"] = remember_me
        session["#{resource_name}_return_to"] = return_to if return_to

        redirect_to two_factor_authentication_path_for(scope)
        return
      end

      def two_factor_authentication_path_for(resource_or_scope = nil)
        scope = Devise::Mapping.find_scope!(resource_or_scope)
        change_path = "#{scope}_two_factor_authentication_path"
        send(change_path)
      end
    end
  end
end
