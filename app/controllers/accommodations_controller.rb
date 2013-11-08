class AccommodationsController < ApplicationController
  def index

    # get all the accommodations
    @accommodations = Accommodation.all

  end
end
