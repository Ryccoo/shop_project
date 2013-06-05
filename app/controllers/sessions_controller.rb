# encoding: UTF-8
class SessionsController < ApplicationController
  def new
    if session[:user_id]
      redirect_to root_url, :alert => "Užívateľ je už prihlásený"
    end
	end

	def create
  	user = User.authenticate(params[:email], params[:password])
  	if user
      session[:user] = { "user_id" => user.id, "provider" => "WEB", "user_name" => user.first_name+" "+user.last_name }
      session[:user_rights] = Group.get_rights(user.group)
      user.last_login=Time.now
      user.save
    	redirect_to root_url, :notice => "Prihlásenie prebehlo úspešne"
  	else
    	flash.now.alert = "Zlé meno alebo heslo"
    	render "new"
  	end
	end

  def create_by_fb
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user] = { "user_id" => user.id, "provider" => "facebook", "user_name" => user.first_name+" "+user.last_name }
    session[:user_rights] = Group.get_rights(user.group)
    redirect_to root_url, :notice => "Prihlásenie prebehlo úspešne"
  end

	def destroy
		session[:user] = nil
    session[:user_rights] = nil
		redirect_to root_url, :notice => "Odhlásenie prebehlo úspešne"
	end
end