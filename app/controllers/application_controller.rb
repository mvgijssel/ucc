class ApplicationController < ActionController::Base

  protect_from_forgery

  # before any action is handled, run the before filter method
  before_filter :handle_request

  def handle_request

    load("#{Rails.root}/ucc/security_model.rb")

    # set the config file
    UCC::SecurityModel.config_file = "#{Rails.root}/ucc.yml"

    # parse the config file
    UCC::SecurityModel.parse

    # handle the request
    UCC::SecurityModel.handle_request request

  end

end


