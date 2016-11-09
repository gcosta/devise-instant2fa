require 'instant2fa'

Warden::Manager.after_authentication do |user, auth, options|
  begin
    hosted_page_url = Instant2fa.create_verification(user.id.to_s)
    auth.session(options[:scope])[DeviseInstant2fa::NEED_AUTHENTICATION] = true
    auth.session(options[:scope])[DeviseInstant2fa::HOSTED_PAGE_URL] = hosted_page_url
    auth.session(options[:scope])[:id] = user.id
  rescue Instant2fa::Errors::MFANotEnabled
  end
end
