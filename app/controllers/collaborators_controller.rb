class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @users = User.all
  end
  
  def share
    #raise (params.inspect)
    @wiki = Wiki.find(params[:wiki_id])
    if params[:user_ids].nil?
      redirect_to :back, notice: "Error no user selected"
    else
      @users = User.friendly.find(params[:user_ids])
      @collaborators = []
      @users.each do |user|
        @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: user.id)
        @collaborators << @collaborator
      end
      if @collaborators.each(&:save)
        redirect_to :back, notice: "wiki collaborator was saved successfully."
      else
        redirect_to :back, notice: "Error adding wiki collaborator. Please try again."
      end
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.friendly.find(params[:id])
    @collaborate = Collaborator.where(wiki_id: @wiki.id, user_id: @user.id).first
   #raise  
    if @collaborate.destroy
      flash[:notice] = "\"#{@user.name}\" was remove successfully."
      redirect_to :back
    else
      flash[:error] = "There was an error deleting the collaborate."
      redirect_to :back
    end
  end
  
  private
  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end