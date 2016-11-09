module ActionDispatch::Routing
  class Mapper
    protected

      def devise_instant2fa(mapping, controllers)
        resource :two_factor_authentication, :only => [:show, :update], :path => 'verify', :controller => controllers[:instant2fa] do
        end
      end
  end
end
