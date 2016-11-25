module DeviseInstant2fa
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:action_controller) do
      include DeviseInstant2fa::Controllers::Helpers
    end

    ActiveSupport.on_load(:action_view) do
      include DeviseInstant2fa::Views::Helpers
    end

    config.after_initialize do
      Devise::Mapping.send :prepend, DeviseInstant2fa::Mapping
      end
  end
end
