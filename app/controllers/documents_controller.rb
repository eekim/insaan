class DocumentsController < ApplicationController

  def index
    @person = Person.find params[:person_id], :include => :documents
    @section = 'documents'
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @person.documents.to_xml }
    end

  end

  def show
    @person = Person.find params[:person_id]
    @document = Document.find params[:id]
    @section = 'documents'
  end

  # download with send_file
  def download
    @document = Document.find params[:id]
    
    send_file @document.public_filename, :type => @document.content_type, :disposition => 'attachment'
    
  end
  
  def new
    @person = Person.find params[:person_id]
    @section = 'documents'
  end
  
  def create
    @person = Person.find params[:person_id]
    @document = Document.new(params[:document])
    
    respond_to do |format|
      if @person.documents << @document
        flash[:notice] = 'Document successfully created.'
        format.html { redirect_to(person_documents_path(@person))}
        format.xml { head :created,
          :location => person_document_path(:person_id => @person.id, :id => @document.id)}
      else
        format.html { 
          @section = 'documents'
          render :action => 'new' }
        format.xml { render :xml => @document.errors.to_xml }
      end
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def edit
  end

  def update
  end

  def destroy
    @person = Person.find params[:person_id]
    @document = Document.find params[:id]
    @document.destroy
    redirect_to person_documents_path(@person)
  end
end
