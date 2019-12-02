module Stardust
  module Hooks
    class Engine < ::Rails::Engine
      isolate_namespace Stardust::Hooks

      initializer :append_migrations do |app|
        root_path = app.root.to_s
        
        if root_path !~ /#{root}/ || root_path == "#{root}/test/dummy"
          config.paths['db/migrate'].expanded.each do |migration_path|
            app.config.paths['db/migrate'] << migration_path
          end
        end
      end
    end
  end
end
