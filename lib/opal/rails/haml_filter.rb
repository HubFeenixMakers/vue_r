require "haml"
require "haml/filters"
require "haml/filters/base"

module Haml
  class Filters
    class Opal < Base
      def compile(node)
        temple = [:multi]
        temple << [:static, "<script type='text/javascript'>\n"]
        temple << [:static, ::Opal.compile(node.value[:text]) ]
        temple << [:static, "\n</script>"]
        temple
      end
    end
  end
end

Haml::Filters.registered[:opal] ||= Haml::Filters::Opal
