class PhotosController < ApplicationController
  
  def index
    @person = Person.find params[:person_id], :include => :photos
    @section = 'photos'
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @person.photos.to_xml }
    end
  end
  
  def show
    @person = Person.find params[:person_id]
    @photo = Photo.find params[:id]
    @section = 'photos'
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @photo.to_xml }
    end

  end

  #   uploading happens in index page now
  
  #   def new
  #     @person = Person.find params[:person_id]
  #     @section = 'photos'
  #   end
  
  def create
    @person = Person.find params[:person_id], :include => :photos
    @photo = Photo.new(params[:photo])
    respond_to do |format|
      if @photo.valid? && @person.photos << @photo
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(person_photos_path(@person)) }
        format.xml { head :created, :location => person_photo_path(:person_id => @person_id, :id => @photo.id) }
      else
        format.html { 
          @section = 'photos'
          render :action => 'index' }
        format.xml { render :xml => @photo.errors.to_xml }
      end
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'index'
  end
  
  # set a default image for person
  def update
    @person = Person.find params[:person_id]
    @photo = Photo.find params[:id]
    
    respond_to do |format|
      # make sure the preferred bit is cleared
      @person.photos.each do |p|
        p.preferred = false
        p.save!
      end
      
      # set preferred photo
      @photo.preferred = true
      
      if @photo.save
        flash[:notice] = 'Default photo was successfully saved.'
        format.html { redirect_to(person_photos_path(@person)) }
        format.xml { head :created,
          :location => person_photo_path(:person_id => @person_id, :id => @photo.id)}
      else
        format.html { 
          @section = 'photos'
          render :action => 'index' }
        format.xml { render :xml => @photo.errors.to_xml }
      end
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'index'
  end
  
  def destroy
    @person = Person.find params[:person_id]
    @photo = Photo.find params[:id]
    @photo.destroy
    redirect_to person_photos_path(@person)
  end
  
end
