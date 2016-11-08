module DeviseInstant2fa
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:action_controller) do
      include DeviseInstant2fa::Controllers::Helpers
    end
  end
end
