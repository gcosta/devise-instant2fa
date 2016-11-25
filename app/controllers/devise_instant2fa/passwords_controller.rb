class DeviseInstant2fa::PasswordsController < Devise::PasswordsController
  def sign_in(resource_or_scope, *args)
    resource = args.last || resource_or_scope

    if resource.respond_to?(:with_instant2fa_verification_url) && resource.with_instant2fa_verification_url

      true
    else
      super
    end
  end
end
