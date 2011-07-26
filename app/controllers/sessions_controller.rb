class SessionsController < ApplicationController

  def create
    session[:user_id] = nil
    if request.post?
      @email = params[:email]
      user = User.authenticate(params[:email], params[:password])
      if user
        login_user(user)
        redirect_to landing_page
      else
        flash[:error] = "Invalid username/password combination"
        redirect_to :action => :new
      end  
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to landing_page
  end

  private

  def login_user(user)  
    session[:user_id] = user.id
  end

end
