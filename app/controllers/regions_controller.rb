class RegionsController < ApplicationController

  def index
    @countries = Country.find :all, :include => :regions
    # @regions = Region.find :all
  end

  def show
    @region = Region.find params[:id]
    @people = @region.people
  end
end
