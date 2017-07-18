class V1::DestinationsController < ApplicationController
  before_action :authenticate_request!

  def index
    @destinations = Destination.filter(params.slice(:name_scope, :city_scope, :locale_scope, :country_scope, :mostReviews, :random))
    json_response(@destinations)
  end

  def show
    @destination = Destination.find(params[:id])
    json_response(@destination)
  end

  def create
    @destination = Destination.create!(destination_params)
    json_response(@destination, :created)
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update!(destination_params)
      render status: 200, json: {
        message: "Your destination has successfully been updated."
      }
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    if @destination.destroy
      render status: 200, json: {
        message: "Your destination has been deleted."
      }
    end
  end

private
  def destination_params
    params.permit(:name, :city, :country, :locale)
  end
end
