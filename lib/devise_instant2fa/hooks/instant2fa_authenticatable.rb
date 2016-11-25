require 'instant2fa'

Warden::Manager.after_authentication do |user, auth, options|
  if user.respond_to?(:with_instant2fa_verification_url)
    if hosted_page_url = user.with_instant2fa_verification_url
      auth.session(options[:scope])[DeviseInstant2fa::NEED_AUTHENTICATION] = true
      auth.session(options[:scope])[DeviseInstant2fa::HOSTED_PAGE_URL] = hosted_page_url
      auth.session(options[:scope])[:id] = user.id
    end
  end
end
