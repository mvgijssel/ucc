module UCC

  class Collection

    attr_accessor :name, :groups, :parent, :param, :model, :security_descriptor, :requests, :id, :type

    def initialize(name, groups, parent, param, model)

      self.name = name

      self.type = name

      self.groups = groups

      self.parent = parent

      self.param = param

      self.model = (model.nil?)? (name) : (model)

      self.security_descriptor = UCC::SecurityDescriptor.new

    end

  end

end