class UsersController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]

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
    @user.enabled = false # NOTE: all new users must be approved
    if @user.save
      # not going to let logins happen automatically... will be approved first
      #self.current_user = @user
      redirect_back_or_default(people_url)
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
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end

end
