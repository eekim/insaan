class UsersController < ApplicationController
  before_filter :check_administrator_role,
                :only => [:index, :destroy, :enable]
  skip_before_filter :login_required,
                     :only => [:new, :create]

  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end

  def show_by_login
    @user = User.find_by_login(params[:login])
    render :action => 'show'
  end

  def new
  end

  def create
    cookies.delete :auth_token
    @user = User.new(params[:user])
    @user.enabled = true # default now true
    if @user.save
      # not going to let logins happen automatically... will be approved first
      #self.current_user = @user
      redirect_back_or_default(home_url)
      flash[:notice] = "Thanks for signing up! Because this is a private system, all users must be verified by and administrator.  When your account is approved the you will be notified."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user)
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated"
      redirect_to :action => 'show', :id => current_user
    else
      render :action => 'edit'
    end
  end

  def destroy # disables, does not delete
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled, false)
      flash[:notice] = "User disabled"
    else
      flash[:error] = "There was a problem disabling this user."
    end
    redirect_to :action => 'index'
  end

  def enable
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled, true)
      flash[:notice] = "User enabled"
    else
      flash[:error] = "There was a problem enabling this user."
    end
    redirect_to :action => 'index'
  end

end
