module UCC

  class Parser

    class << self

      def parse(security_model, data)

        # create the configuration
        config = data[:config]

        # create the collections
        collections = create_collections data[:collections]

        # create the security objects
        create_security_descriptors collections, data[:security], nil, true

        # copy the collections to the security model
        security_model.collections = collections

      end

      private

      def create_collections(data)

        collections = Hash.new

        data.each do |name, value|

          collections[name] = Collection.new name, value

        end

        return collections

      end

      def is_collection?(name, collection)

        collection.has_key? name

      end

      def is_controller?(name)

        # double bang converts to true or false
        # check if the last part of the name contains _controller
        !!(name =~ /_controller$/)

      end

      def create_security_descriptors(collections, data, parent, is_root = false)

        # can only be 1 root
        data.each do |node, children|

          # is controller?
          is_collection = false
          is_controller = false

          if is_collection? node, collections

            is_collection = true

          end

          if is_controller? node

            raise "Node #{node} cannot match to both a controller and a collection" if is_collection

            raise "Controller '#{node}' should be defined within a collection" if is_root

            is_controller = true

          end

          raise "Node '#{node}' didn't match a Container or a Controller" if !is_controller && !is_collection

          if is_controller

            # controller is a part of the security descriptor
            parent.security_descriptor.add node, children

          end

          if is_collection

            # get the container
            collection = collections[node]

            # set the parent
            collection.parent = parent

            # do stuff for a container
            # container can contain other containers
            create_security_descriptors(collections, children, collection)

          end

        end

      end

    end

  end

end