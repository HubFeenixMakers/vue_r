require 'opal-parser'

module VueR
  class Mounter
    HANDLEBARS = /{{\s?([^}]*)\s?}}/
    def initialize( id , app )
      @root = $document[id]
      @application = app
    end

    def mount
      mount_Element(@root)
    end

    def mount_Text elem
      text = elem.text
      scan = text.scan(HANDLEBARS)
      return unless scan.length > 0
      raise "only one curly per text implemented not:#{scan.length}" if scan.length > 1
      match = text.match(HANDLEBARS)
      str_before = text[0 ... match.begin(0)]
      str_after = text[ match.end(0) .. -1]
      ruby = match[0][2 ... -2]
      puts "Text: #{ruby}"
      proc = Proc.new do
        elem.text = str_before + @application.eval(ruby).to_s + str_after
      end
      @application.watch_effect(proc)
    end

    def mount_Element(elem)
      elem.attributes.each do |name , value|
        mount_attribute(elem , name) if name.start_with?("r_")
        mount_event(elem , name)  if name.start_with?("e_")
      end
      elem.children.each do |elem|
        base_name = elem.class.to_s.split("::").last
        send "mount_#{base_name}" , elem
      end
    end

    def mount_attribute(element , name)
      native_name = name[2 .. -1]
      ruby = element[name]
      old_value = element[native_name]
      puts "Attribute: #{ruby}"
      proc = Proc.new do
        element[native_name] = old_value + " " + @application.eval(ruby).to_s
      end
      @application.watch_effect(proc)
    end


    def mount_event(element , name)
      native_name = name.gsub("e_" , "")
      ruby = element[name]
      puts "Event: #{native_name}:#{ruby}"
      element.on!(native_name) do
        got = @application.eval(ruby)
        puts "Clicked #{got}"
      end
    end
  end
end
