class ApplicationController < ActionController::Base

  protect_from_forgery

  # before any action is handled, run the before filter method
  before_filter :handle_request

  def handle_request

    load("#{Rails.root}/ucc/security_model.rb")

    UCC::SecurityModel.config_file = "#{Rails.root}/user_content_control.yml"
    UCC::SecurityModel.parse
    UCC::SecurityModel.handle_request

  end

end


