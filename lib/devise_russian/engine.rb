module DeviseRussian
  class Engine < ::Rails::Engine
    isolate_namespace DeviseRussian
    engine_name "devise_russian"

    initializer "devise_russian.includers" do |app|
      ActionController::Base.send :include, DeviseRussian::Controllers::Base
      ActiveRecord::Base.send :include, DeviseRussian::Models::Base
    end
  end
end
