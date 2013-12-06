=begin

- add join(group) / leave(group) methods to User model
  - when model determined as set_container, project instance can also be passen to join/leave methods
- when model is set_container, add persistence relation to creating/deleting groups in user_group table
- link_to filter, based on same method the request is determined as accessible
- everything happens BEFORE controllers are created -> more efficient


=end

# get the syntax
syntax = data[:syntax]

# syntax not defined, raise error
raise 'syntax tag not defined' if syntax.nil?

# if the syntax version is unknown, raise error
raise "version #{syntax} unknown" if syntax != 1.0

# get the config data
config = data[:config]

# get the container data
container_data = data[:container]

# get the security data
security_data = data[:security]

# include UCC

s = UCC::SecurityModel.new

puts s

# get the current url
# current_uri = request.env['PATH_INFO']
#path = Rails.application.routes.recognize_path '/1/pages/1/'

# match the acquired path to the sets in the sets array
# if more than 1 match, throw error. shouldn't be possible
# if not match -> ?
# if match ->



