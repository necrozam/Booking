class UsersController < ApplicationController
	before_action :login?,only: %i(show edit update)
	before_action :load_user,only: %i(show edit update destroy)
	before_action :correct_user?,only: %i(edit update)

def destroy

	if @user.destroy
		flash[:success]="Delete thành công !"
		redirect_to users_path
	else
			flash.now[:danger]="Delete không thành công  ! "
			
	end
		#redirect_to users_path
end

	def index
		@users=User.paginate(page: params[:page],per_page:20)
		
	end
	def show
		@user = User.find_by id:params[:id]
		@microposts = @user.microposts.paginate(page: params[:page])
		unless @user
			flash[:danger] = "Not found user_id: #{params[:id]}"
			redirect_to root_path
		end
	end
	def new
		@user= User.new
	end
	
	def edit
		@user = User.find(params[:id])
	end

	def create
		@user=User.new user_params
		
		if @user.save
			log_in @user
			flash.now[:success]="Create account successful ! "
			redirect_to @user
		else
			flash.now[:danger]="Create account fail ! "
			render :new	
		end
	end	
	def update 
		@user= User.find_by id:params[:id]
	if @user.update user_params
		flash[:success]="update	thành công"
		redirect_to @user
	else 
		flash.now[:danger]=" update thất bại "
		render :edit
	end	
	end

	def is_login?
		if current_user.nil?
			flash[:danger]= "you need log in"
			redirect_to login_path
		end
	end
		
	private
	def user_params
		params.require(:user).permit(:name, :email,:password,:password_confirmation)
	end

	def load_user
		@user= User.find_by id: params[:id]
		unless @user
			flash[:danger]= "Not found user_id: #{params[:id]}"
			redirect_to root_path
		end
	end

	def correct_user?
		if @user != current_user
		flash[:danger] = "Access denied"
		redirect_to root_path
	end
	end
end
