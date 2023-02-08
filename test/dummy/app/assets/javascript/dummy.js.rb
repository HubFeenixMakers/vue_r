require "opal"
require "native"
require 'promise'
require 'opal-parser'
require 'browser/setup/mini'


require "vue_r/application"
require "vue_r/mounter"

puts "hello world!"

# Uncomment the following to print out you're hello-world with Opal:
#
#
# The following will append a hello-world to your <body> element:
#
#   require "native"
#   $$[:document].addEventListener :DOMContentLoaded do
#     $$[:document][:body][:innerHTML] += '<h2>Hello World!</h2>'
#   end
