# encoding: UTF-8
class UsersController < ApplicationController
  
  def user
    unless current_user
      redirect_to root_url, :alert => "Nie ste prihlásený"
    else
      @user = User.find(current_user["user_id"]);
    end

  end


  def new
    if current_user
      redirect_to root_url, :alert => "Pred vytvorením nového užívateľa sa prosím odhláste"
    else
  	 @user = User.new
    end
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to root_url, :notice => "Registrácia prebehla úspešne."
  	else 
  		render "new"
  	end
  end

  def edit
    unless current_user
      redirect_to root_url, :alert => "Nie ste prihlásený"
    else
      @user = User.find(current_user["user_id"]);
    end
  end

  def update
    @user = User.find(current_user["user_id"]);
    if @user.update_attributes(params[:user])
      redirect_to logged_path, :notice => "Profil bol upravený"
    else
      render "edit"
    end
  end

  def change_password
    unless current_user["user_id"]
      redirect_to root_url, :alert => "Nie ste prihlásený"
    else
      if current_user["provider"] == "WEB"
        @user = User.find(current_user["user_id"]);
      else
        redirect_to root_url, :alert => "Táto akcia nie je možná"
      end
    end
  end

  def update_pass
    unless current_user["user_id"]
      redirect_to root_url, :notice => "Nie ste prihlásený"
    else
      @user = User.find(current_user["user_id"]);
      proceed = User.authenticate(@user.email, params[:user][:old_password])
      if proceed
        if @user.update_attributes(params[:user])
          redirect_to logged_path, :notice => "Heslo bolo zmenené"
        else
          render "change_password"
        end
      else
        redirect_to logged_changepwd_path, :alert => "Zlé heslo"
      end
    end
  end

  def show
    @user = User.find(params[:id])
    render "user"
  end

  def index
    @users = User.find(:all, :order => 'last_name, first_name')
  end

end