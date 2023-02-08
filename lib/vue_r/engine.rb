require "opal-rails"
require "opal-browser"

module VueR
  class Engine < ::Rails::Engine
    isolate_namespace VueR

    initializer "vue_r.assets.precompile" do |app|
      app.config.assets.precompile += %w( vue_r.js )
    end

  end
end
