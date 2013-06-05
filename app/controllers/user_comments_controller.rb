# encoding: UTF-8
class UserCommentsController < ApplicationController
  def index
  	@user = User.find(params[:user_id])
  	@comments = @user.user_comments
  end

  def create
		@user = User.find(params[:user_id])
  	@comments = @user.user_comments
  	@comment = @user.user_comments.new(params[:user_comment])
    if session[:user_id]
    	if @comment.save
    		redirect_to user_user_comments_path(@user)
    	else
    		redirect_to user_user_comments_path(@user), :alert => "Chyba pri ukladaní"
    	end
    else 
      redirect_to user_user_comments_path(@user), :alert => "Nie ste prihlásený"
    end
  end

  def user_comments
		unless session[:user_id]
			redirect_to root_url, :alert => "Nie ste prihlásený"			
		else
			@user = User.find(session[:user_id])
			@comments = @user.user_comments
			render "index"
		end
  end
end
