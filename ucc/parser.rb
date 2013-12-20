module UCC

  class Parser

    class << self

      def parse(security_model, data)


        # create the configuration
        config      = data[:config]

        # create the collections
        collections = create_collections data[:collections]

        # update the collections now all collections are known
        update_collections collections

        # create the security objects
        create_security_descriptors collections, data[:security]

        # update the collections on the model
        security_model.collections = collections

      end

      private

      def create_collections(data)

        # so can be accesses with both symbols and strings
        collections = HashWithIndifferentAccess.new

        data.each do |collection_name, collection_settings|

          # create a new collection from the data
          collections[collection_name] = Collection.new(
              collection_name,
              collection_settings[:groups],
              collection_settings[:parent],
              collection_settings[:param],
              collection_settings[:model]
          )

        end

        return collections

      end

      def update_collections(collections)

        collections.each do |collection_name, collection|

          update_parent collections, collection

          define_requests collection

        end

      end

      def update_parent(collections, collection)

        # if the collection has the parent property defined
        unless collection.parent.nil?

          if collections.has_key? collection.parent

            # store the actual collection in the parent property
            collection.parent = collections[collection.parent]

          else

            # collection with the provided name doesn't exist
            raise "Unknown collection parent '#{collection.parent}'"

          end

        end

      end

      def remove_controller_string(string)

        string.sub(%r{_controller$}, '')

      end

      def define_requests(collection)

        top_request = requests_from_param(collection.param, true)

        requests = Array.new

        current_collection = collection

        until current_collection.parent.nil?

          # set the parent as the current collection
          current_collection = current_collection.parent

          # get the possible requests based on the param property
          r = requests_from_param(current_collection.param)

          # only add the request if isn't empty
          requests << r unless r.empty?

        end

        requests = top_request.product(*requests)

        requests = top_request if requests.empty?

        collection.requests = requests

      end

      def requests_from_param(param, last = false)

        matches = Array.new

        # switch on param
        case param

          # when the last part is _controller
          when /_controller$/

            if last

              matches << {:controller => remove_controller_string(param)}

            end

            matches << {"#{remove_controller_string(param).singularize}_id".to_sym => true}

          # when not nil
          when /.+/

            matches << {param.to_sym => true}

          else

            # do nothing

        end

        return matches

      end

      def create_security_descriptors(collections, data)

        data.each do |collection_name, value|

          raise "Error in security descriptor: unknown collection '#{collection_name}'" unless collections.has_key? collection_name

          # add controllers to the security descriptor
          add_controllers_to_descriptor(
              collections[collection_name].security_descriptor,
              value
          )

        end

      end

      def add_controllers_to_descriptor(security_descriptor, data)

        data.each do |controller, value|

          security_descriptor.add(controller, value)

        end

      end

    end

  end

end