module UCC

  class Collection

    attr_accessor :name, :model, :controller, :groups, :id, :parent, :security_descriptor

    def initialize(name, data)

      self.name = name

      self.model = data[:model]

      self.controller = data[:controller]

      self.id = data[:id]

      self.groups = data[:groups]

      self.security_descriptor = UCC::SecurityDescriptor.new

    end

    def match_request?(params)

      # get the requests for this collection
      requests = associated_request


       false

    end

    def associated_request

      request = [controller]

      request.concat(parent.associated_request) unless parent.nil?

      return request

    end

  end

end