require "opal-rails"

module VueR
  class Engine < ::Rails::Engine
    isolate_namespace VueR
  end
end
