module UCC

  class SecurityDescriptor

    attr_accessor :controller

    def initialize

      self.controller = HashWithIndifferentAccess.new

    end

    def add(controller, value)

      self.controller[controller] = value

    end

  end

end