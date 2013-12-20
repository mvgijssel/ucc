module ApplicationHelper

  def current_user

     User.find(1)

  end

  def current_collection

    UCC::SecurityModel.active_collection

  end

end
