# encoding: UTF-8
class SessionsController < ApplicationController
  def new
    @translations = Translation.get("sessions/new","en")
    if current_user
      redirect_to root_url, :alert => Translation.make("User is already logged in",@translations)
    end
	end

	def create
    @translations = Translation.get("sessions/new",app_lang)
  	user = User.authenticate(params[:email], params[:password])
  	if user
      session[:user] = { "user_id" => user.id,
                          "provider" => "WEB",
                          "user_name" => user.first_name+" "+user.last_name }
      session[:user_rights] = Group.get_rights(user.group)
      session[:lang] = "en"
      user.last_login=Time.now
      user.save
    	redirect_to root_url, :notice => Translation.make("Logged in successfully",@translations)
  	else
    	flash.now.alert = Translation.make("Incorrect name or password",@translations)
    	render "new"
  	end
	end

  def create_by_fb
    @translations = Translation.get("sessions/new",app_lang)
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user] = { "user_id" => user.id, 
                        "provider" => "facebook",
                        "user_name" => user.first_name+" "+user.last_name }
    session[:user_rights] = Group.get_rights(user.group)
    session[:lang] = "sk"
    redirect_to root_url, :notice => Translation.make("Logged in successfully",@translations)
  end

	def destroy
		session[:user] = nil
    session[:user_rights] = nil
    @translations = Translation.get("sessions/destroy",app_lang)
		redirect_to root_url, :notice => Translation.make("Logged out successfully",@translations)
	end
end