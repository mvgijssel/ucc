module UCC

  class Parser

    class << self

      def parse security_model, data

        config = data[:config]

        # create the set containers
        security_model.containers = create_containers data[:container]

        security = data[:security]

      end

      def create_containers data



      end

    end

  end

end