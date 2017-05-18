class Devise::Instant2faController < DeviseController
  if self.respond_to?(:prepend_before_action)
    prepend_before_action :find_resource_and_require_password_checked, :only => [
      :show, :update
    ]
  else
    prepend_before_filter :find_resource_and_require_password_checked, :only => [
      :show, :update
    ]
  end

  def show
    @hosted_page_url = session["#{resource_name}_hosted_page_url"]
    if @resource.authy_user
      after_two_factor_success_for(@resource)
    end
  end

  def update
    render :show and return if params[:instant2faToken].nil?

    begin
      Instant2fa.confirm_verification(@resource.id.to_s, params[:instant2faToken])
      after_two_factor_success_for(@resource)
    rescue Instant2fa::Errors::VerificationMismatch
      after_two_factor_fail_for(@resource)
    rescue Instant2fa::Errors::VerificationFailed
      after_two_factor_fail_for(@resource)
    end
  end

  private

  def find_resource
    @resource = send("current_#{resource_name}")

    if @resource.nil?
      @resource = resource_class.find(session["#{resource_name}_id"])
    end
  end

  def find_resource_and_require_password_checked
    find_resource

    if @resource.nil? || session[:"#{resource_name}_password_checked"].to_s != "true"
      redirect_to invalid_resource_path
    end
  end

  def after_two_factor_success_for(resource)
    remember_device if params[:remember_device].to_i == 1
    if session.delete("#{resource_name}_remember_me") == true && resource.respond_to?(:remember_me=)
      resource.remember_me = true
    end
    sign_in(resource_name, resource)
    flash[:error] = "Instant2fa has been bought by Authy! Please register for Authy 2-factor authentication before June 6th to continue to protect your account."
    redirect_to "/users/enable_authy"
  end

  def after_two_factor_fail_for(resource)
    set_flash_message :alert, :attempt_failed, now: true
    sign_out(resource)
    redirect_to :root
  end
end
