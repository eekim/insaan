class RegionsController < ApplicationController

  def index
    @countries = Country.find :all, :include => :regions
    # @regions = Region.find :all
  end

  def show
    @region = Region.find_by_permalink params[:id]
    @people = @region.people
  end
end
