module DeviseInstant2fa
  module Mapping
    private

    def default_controllers(options)
      options[:controllers] ||= {}
      options[:controllers][:passwords] ||= "devise_instant2fa/passwords"
      super
    end
  end
end
