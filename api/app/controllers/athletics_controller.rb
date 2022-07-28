class AthleticsController < ApplicationController
  def index
    @athletics = Athletic.all
  end
end
