class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.paginate(:per_page => 20, :page => params[:page], :order => 'name')
  end

  def show
    @org = Organization.find params[:id]
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
