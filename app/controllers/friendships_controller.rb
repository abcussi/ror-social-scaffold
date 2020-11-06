class FriendshipsController < ApplicationController
  include FriendshipsHelper
  # def new
  #   @friendship = Friendship.new
  # end

  # def create
  #  @friendship = Friendship.new(friendship_params)
  #  respond_to do |format|
  #   if @friendship.save
  #     format.html {redirect_to @friendship}
  #   else
  #     format.html{render 'new'}
  #   end
  #   end
  # end

  # private 
  # def friendship_params
  #   params.require(:friendship).permit(:user_id, :request_id, :status)
  # end
  def create
    #@user = User.find(params[:user_id])
    @friendship = current_user.friend_sent.build(request_id: params[:request_id], status:nil)
    return if friend_request_sent?(User.find(params[:request_id]))
    if @friendship.save
      flash[:success] = 'Friend Request sent'
    else
      flash[:danger] = 'Friend Request Failed'
    end
  end
end
