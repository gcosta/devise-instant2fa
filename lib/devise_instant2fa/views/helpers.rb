module DeviseInstant2fa
  module Views
    module Helpers
      def instant2fa_settings_view(resource)
        instant2fa_javascript_tag resource.instant2fa_settings_url
      end

      def instant2fa_verification_form(resource_name, url)
        form_tag([resource_name, :two_factor_authentication], :method => :put) do
          instant2fa_javascript_tag url
        end
      end

      private

      def instant2fa_javascript_tag(uri)
        javascript_include_tag 'https://js.instant2fa.com/hosted.js', class: 'instant2fa-page', 'data-uri' => uri 
      end
    end
  end
end
