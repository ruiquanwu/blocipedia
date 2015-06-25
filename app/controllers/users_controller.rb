 class UsersController < ApplicationController
   before_action :authenticate_user!, except: [:show]
 
   def index
     @users = User.all
   end
   
   def update
     if current_user.update_attributes(user_params)
       flash[:notice] = "User information updated"
       redirect_to edit_user_registration_path
     else
       flash[:error] = "Invalid user information"
       redirect_to edit_user_registration_path
     end
   end
 
   def show
     @user = User.find(params[:id])
   end
   
   def downgrade
     @user = User.find(params[:user_id])
     @user.role = "standard"
     wiki_to_public @user
     if @user.save
       flash[:notice] = "Plan has been downgraded to standard"
     else
       flash[:error] = "There is error on downgrading plan"
     end
     redirect_to :back
   end
   private
 
   def user_params
        params.require(:user).permit(:name)
   end
   
   def wiki_to_public user
     user.wikis.each do |wiki|
       if wiki.private
         wiki.private = false
         wiki.save
       end
     end
   end
 end