module UCC

  class SetContainer

    attr_accessor :name, :model, :controller

    def initialize name, data

      name = name

      model = data[:model]

      controller = data[:controller]

      id = data[:id]

    end

  end

end