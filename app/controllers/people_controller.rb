class PeopleController < ApplicationController
  
  def index

    @browse_by = (params[:browse_by] if ['name', 'fellowship', 'activity', 'search'].include?(params[:browse_by])) || 'name'

    case @browse_by
    when "name"
      filter = "true"
      sort = params[:sort] || "last_name ASC" # make method for this
    when "fellowship"
      filter = make_filter_string(params)
      sort = params[:sort] || "last_name ASC" # make method for this
    when "activity"
      filter = "true"
      sort = params[:sort] || "people.updated_at DESC"
    end

    # add form param for this
    items_per_page = params[:per_page] || 25

    # if there is a name_query perform name search, otherwise run general filter
    # need to combine this into a single form and method
    if params[:name_query] != nil and !params[:name_query].empty?
      search = params[:name_query]
      @people = Person.search(search, params[:page], items_per_page)
    else
      @people = Person.filter(filter, sort, params[:page], items_per_page)
    end

  end

  def show
    @person = Person.find params[:id]
    @section = 'main'
  end

  def new
    @person = Person.new
    @countries = Country.find :all, :include => :regions

    @person.email_addresses.build
    @person.phone_numbers.build
    @person.addresses.build
    @person.websites.build
    @person.im_addresses.build

  end

  def create
    @person = Person.new params[:person]
    if @person.save
      flash[:notice] = "Successfully created #{@person.name}."
      redirect_to person_path(@person)
    else
      @countries = Country.find :all, :include => :regions
      render :action => :new
    end
  end

  def edit
    @person = Person.find params[:id]
    @countries = Country.find :all, :include => :regions
    @section = 'edit'
  end

  def update
    params[:person][:existing_address_attributes] ||= {}
    params[:person][:existing_email_address_attributes] ||= {}
    params[:person][:existing_im_address_attributes] ||= {}
    params[:person][:existing_phone_number_attributes] ||= {}
    params[:person][:existing_website_attributes] ||= {}
    params[:person][:competency_ids] ||= []

    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      flash[:notice] = "Successfully updated #{@person.name}."
      redirect_to person_path(@person)
    else
      render :action => 'edit'
    end
  end

  def destroy
  end

  private

  def make_filter_string(params)
    # create a filter string, this can be spun off as a method, or find a better way to compose
    filter_year = params[:year] || ""
    filter_program = params[:program] || ""
    filter_country = params[:country] || ""
    year = "fellowships.year='" + filter_year + "'" if !filter_year.empty?
    program = "fellowships.program_id='" + filter_program + "'" if !filter_program.empty?
    country = "fellowships.country='" + filter_country + "'" if !filter_country.empty?
    filter = [year, program, country].reject(&:blank?) * ' AND '
    filter = "fellowships_count != 0" if filter.empty?

    return filter
  end

end
