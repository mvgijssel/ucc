load "#{Rails.root}/ucc/collection.rb"
load "#{Rails.root}/ucc/parser.rb"
load "#{Rails.root}/ucc/security_descriptor.rb"

module UCC

=begin

- add join(group) / leave(group) methods to User model
- when model determined as set_container, project instance can also be passen to join/leave methods
- when model is set_container, add persistence relation to creating/deleting groups in user_group table
- link_to filter, based on same method the request is determined as accessible
- everything happens BEFORE controllers are created -> more efficient

=end

  class SecurityModel

    # class level methods
    class << self

      def config_file=(file_location)

        @config_file = file_location

      end

      def parse

        # if config file not set, raise error
        raise 'config file not set' if @config_file.nil?

        # get the file content
        file_content = File.read @config_file

        # convert the file content to a hash
        data         = YAML.load file_content

        # convert the hash to a hash which can be accessed with symbols instead of string
        data         = HashWithIndifferentAccess.new(data)

        # parse the data, pass this class
        UCC::Parser.parse(self, data)

      end

      def active_collection

        # return the active container
        @active_collection

      end

      def active_collection=(collection)

        @active_collection = collection

      end

      def collections

        @collections

      end

      def collections=(collections)

        @collections = collections

      end

      def handle_request request

        # get the current uri
        current_uri    = request.env['PATH_INFO']

        # instantiate matches array
        matches        = Array.new

        # get the params from the current uri, only controller params are returned
        active_request = Rails.application.routes.recognize_path current_uri

        # iterate each collection to see if it is a match with the active request
        @collections.each do |name, collection|

          # match the params to the request_matches
          if match_request(active_request, collection.requests)

            matches << collection

          end

        end

        raise "No container matches the current request '#{current_uri}'" if matches.length == 0

        raise "More than 1 match for the current request '#{current_uri}': #{matches.inspect}" if matches.length > 1

        # set the active collection to the match
        self.active_collection = matches[0]

        # get the id!!
        if active_collection.param =~ /_controller$/

          if controller_name(active_request[:controller]) == active_collection.param

            active_collection.id = active_request[:id]

          else

            s = param_name(active_collection.param)

            active_collection.id = active_request[param_name(active_collection.param).to_sym]

          end

        else

          active_collection.id = active_request[active_collection.param]

        end

      end

      def param_name(controller_name)

        "#{controller_name.sub(/_controller/, '').singularize}_id"

      end

      def match_request(active_request, requests)

        # for each of the possible requests for the collection
        requests.each do |request|

          # start with a true match
          match = true

          # iterate each condition of the request
          request.each do |param|

            # each condition of a request consists of a param with a single key=>pair hash
            # each param must match a param of the active_request
            # the param only exists of a single hash, other way?
            param.each do |key, value|

              unless active_request.has_key? key
                match = false
                break
              end

              # unless the value of the parameter is the same as the active request
              # OR the value of the param is true
              unless active_request[key] == value || value == true
                match = false
                break
              end

            end

            unless match
              # no reason to try the other possibilities, because a part of the request didn't match
              break
            end

          end

          if match

            # clone the active_request
            match_request = active_request.clone

            # delete the id key
            match_request.delete(:id)

            # delete the action key
            match_request.delete(:action)

            # remove the keys from the match request
            request.each do |param|

              param.each do |key, value|

                match_request.delete(key)

              end

            end

            # the entire request matches to the active_request
            # but now check if other parts of the active request aren't collection parameters
            match_request.each do |key, value|

              # the request belongs to another collection, no match
              if collection_request? key, value

                # set the match to false
                match = false

                # no use in iterating further
                break

              end

            end

            # if there is still a match, the request matches the active request
            if match

              return true

            end

          end

        end

        # nothing matched, return false
        return false

      end

      def controller_name(param)

        "#{param}_controller"

      end

      def collection_request?(name, value)

        # is there a collection with a request listening to this param?

        # set the default match to false
        match = false

        collections.each do |collection_name, collection|

          if name == :controller

            if collection.param == controller_name(value)
              match = true
            end

          else

            if collection.param == name
              match = true
            end

          end

          if match
            # if there is a match, no need to iterate further
            break
          end

        end

        return match

      end

    end

  end

end