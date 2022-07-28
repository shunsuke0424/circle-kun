class ActivityDaysController < ApplicationController
  def index
    render json: { activity_days: ActivityDay.to_options }
  end
end