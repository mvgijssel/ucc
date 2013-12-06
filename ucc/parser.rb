module UCC

  class Parser

    class << self

      def parse(security_model, data)

        # create the configuration
        config = data[:config]

        # create the set containers
        containers = create_containers data[:container]

        # create the security objects
        create_security_descriptors containers, data[:security], nil, true

        # copy the containers to the security model
        security_model.containers = containers

      end

      private

      def create_containers(data)

        containers = Hash.new

        data.each do |name, value|

          containers[name] = SetContainer.new name, value

        end

        return containers

      end

      def is_container?(name, containers)

        containers.has_key? name

      end

      def is_controller?(name)

        # double bang converts to true or false
        !!(name =~ /_controller/)

      end

      def create_security_descriptors(containers, data, parent, is_root = false)

        # can only be 1 root
        data.each do |node, children|

          # is controller?
          is_container = false
          is_controller = false

          if is_container? node, containers

            is_container = true

          end

          if is_controller? node

            raise "Node #{node} cannot match to both a controller and a container" if is_container

            raise "Controller '#{node}' should be defined within a container" if is_root

            is_controller = true

          end

          raise "Node '#{node}' didn't match anything" if !is_controller && !is_container

          if is_controller

            # controller is a part of the security descriptor
            parent.security_descriptor.add node, children

          end

          if is_container

            # get the container
            container = containers[node]

            # set the parent
            container.parent = parent

            # do stuff for a container
            # container can contain other containers
            create_security_descriptors(containers, children, container)

          end

        end

      end

    end

  end

end