class SessionsController < ApplicationController
  def new
  end

  def create
  	@user =User.find_by email: params[:session][:email].downcase
       if @user.present? && @user.authenticate(params[:session][:password])
  		#xu ly login
      login_user @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      flash[:success]="login successfull"
      redirect_to @user
     else
       flash.now[:danger]= "Email or password incorrect"
        render :new
     end
end
  	#neu user ko ton tai thi tra ve loi
  def destroy
	   forget(current_user)
     session.delete(:user_id)
     @current_user= nil
     flash[:success] = "Goodbye"
     redirect_to root_path
  end
end
