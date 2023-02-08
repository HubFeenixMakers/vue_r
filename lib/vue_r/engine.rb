require 'opal'
require "opal-rails"
require "opal-browser"

module VueR
  class Engine < ::Rails::Engine
    isolate_namespace VueR

  end
end

Opal.append_path File.expand_path('../../../opal', __FILE__)
Opal.use_gem 'opal-browser'
