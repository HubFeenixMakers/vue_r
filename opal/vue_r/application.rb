module VueR
  class Application

    def initialize(hash)
      hash.each do |k,v|
        wrap_attr(k,v)
      end
      @effect = nil
      @subscribers = {}
    end

    def wrap_attr(k,v)
      instance_variable_set "@#{k}" , v
      define_getter(k)
      define_setter(k)
    end

    def define_getter(k)
      self.class.define_method k.to_sym do
        track(k)
        instance_variable_get "@#{k}".to_sym
      end
    end

    def define_setter(k)
      self.class.define_method "#{k}=".to_sym  do |new_v|
        instance_variable_set "@#{k}" , new_v
        trigger(k)
      end
    end

    def track( key )
      puts "Tracking:#{key}-#{@effect.hash}"
      return unless @effect
      get_subscribers_for(key) << @effect
    end

    def trigger(key)
      puts "Trigger:#{key}"
      effects = get_subscribers_for(key)
      effects.each {|effect| effect.call() }
    end

    def get_subscribers_for(key)
      key = key.to_sym
      unless @subscribers.has_key?(key)
        @subscribers[key] = Set.new
      end
      @subscribers[key]
    end

    def mount(on_class)
      @mounter = Mounter.new(on_class , self)
      @mounter.mount
    end

    def watch_effect( update_proc )
      effect = Proc.new do
        @effect = effect
        update_proc.call
        @effect = nil
      end
      effect.call
    end

    def send_self(expression)
      method , args = decompose(expression)
      method = method.strip
      puts "Sending #{method}(#{args&.join(',')})"
      if(args == nil or args.empty?)
        self.send( method )
      else
        self.send( method , *args )
      end
    end

    def decompose(expression)
      parts = expression.split("(")
      method = parts.shift
      raise "No nested brackets" if parts.length > 1
      puts "METHOD:#{method}"
      return [method , [] ] if parts.empty?
      args = parts.first.split(")").first.split(",")
      args = args.collect{| arg | transform_arg(arg) }
      return [method , args]
    end

    def transform_arg(argument)
      arg = argument.strip
      puts "Arg:#{arg}:"
      return true if arg == "true"
      return false if arg == "false"
      return nil if arg == "nil"
      return arg.to_i if arg == arg.to_i.to_s
      arg.gsub('"' ,"").gsub("'" , "")

    end
  end
end
