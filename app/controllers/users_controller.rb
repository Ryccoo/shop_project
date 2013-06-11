# encoding: UTF-8
class UsersController < ApplicationController
  
  def new
    @translations = Translation.get("users/new", "en")
    if current_user
      redirect_to root_url, :alert => Translation.make("Log out before creating new account",@translations)
    else
  	 @user = User.new
    end
  end

  def create
    @translations = Translation.get("users/new", "en")
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to root_url, :notice => Translation.make("Registration sucessful",@translations)
  	else 
  		render "new"
  	end
  end

  def edit
    @translations = Translation.get("users/new", "en")
    unless current_user
      redirect_to root_url, :alert => Translation.make("Not logged in",@translations)
    else
      @user = User.find(current_user["user_id"]);
    end
  end

  def update
    @user = User.find(current_user["user_id"]);
    if @user.update_attributes(params[:user])
      redirect_to logged_path, :notice => Translation.make("Profile sucessfully edited",@translations)
    else
      render "edit"
    end
  end

  def change_password
    @translations = Translation.get("users/new", "en")
    unless current_user["user_id"]
      redirect_to root_url, :alert => Translation.make("Not logged in",@translations)
    else
      if current_user["provider"] == "WEB"
        @user = User.find(current_user["user_id"]);
      else
        redirect_to root_url, :alert => Translation.make("Action impossible",@translations)
      end
    end
  end

  def update_pass
    @translations = Translation.get("users/new", "en")
    unless current_user["user_id"]
      redirect_to root_url, :notice => Translation.make("Not logged in",@translations)
    else
      @user = User.find(current_user["user_id"]);
      proceed = User.authenticate(@user.email, params[:user][:old_password])
      if proceed
        if @user.update_attributes(params[:user])
          redirect_to user_path(current_user["user_id"]), :notice => Translation.make("Password changed",@translations)
        else
          render "change_password"
        end
      else
        redirect_to logged_changepwd_path, :alert => Translation.make("Wrong password",@translations)
      end
    end
  end

  def show
    @user = User.find(params[:id])
    render "user"
  end

  def index
    result = User.find(:all, :order => 'last_name, first_name')
    @users = Kaminari.paginate_array(result).page(params[:page]).per(10)
  end

end