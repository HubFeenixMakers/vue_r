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

  end
end
