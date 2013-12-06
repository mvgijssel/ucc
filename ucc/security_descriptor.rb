module UCC

  class SecurityDescriptor

    attr_accessor :controller

    def initialize

      self.controller = Hash.new

    end

    def add(controller, value)

      self.controller[controller] = value

    end

  end

end