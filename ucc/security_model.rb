load "#{Rails.root}/ucc/set_container.rb"
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
        data = YAML.load file_content

        # convert the hash to a hash which can be accessed with symbols instead of string
        data = HashWithIndifferentAccess.new(data)

        # parse the data, pass this class
        UCC::Parser.parse(self, data)

      end

      def active_container

        # return the active container
        @active_container

      end

      def containers

        @containers

      end

      def containers=(containers)

        @containers = containers

      end

      def handle_request request

        # get the current uri
        current_uri = request.env['PATH_INFO']

        # get the params from the current uri, only controller params are returned
        params = Rails.application.routes.recognize_path current_uri

        # instantiate new array for all the matches
        matches = Array.new



        # the container array to a array of possible items in the request
        # container -> how the request for that container would look like
        # compare with the actual request (params) -> array of arrays
        # but what to do with controller: page, because it is not a container
        # first remove all non containers?






        @containers.each do |name, set_container|

           if set_container.match_request? params

             matches << set_container

           end

        end

        #raise "No container matches the current request '#{current_uri}'" if matches.length == 0

        #raise "More than 1 match for the current request '#{current_uri}': #{matches.inspect}"


      end

    end

  end

end