module UCC

  class Parser

    class << self

      def parse security_model, data

        # create the configuration
        config = data[:config]

        # create the set containers
        security_model.containers = create_containers data[:container]

        # create the security object
        security = data[:security]

      end

      def create_containers data

          containers = Array.new

          data.each do |node, value|

            containers.push SetContainer.new node, value

          end

          return containers

      end

    end

  end

end