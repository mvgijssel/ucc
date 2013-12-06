module UCC

  class SecurityModel

    # class level methods
    class << self

      def config_file=(file_location)

        @config_file = file_location

      end

      def parse

        # get the file content
        file_content = @config_file

        # convert the file content to a hash
        data = YAML.load file_content

        # convert the hash to a hash which can be accessed with symbols instead of string
        data = HashWithIndifferentAccess.new(data)


      end

      def active_container

      end

    end

  end

end