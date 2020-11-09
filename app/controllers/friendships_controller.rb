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
    @friendship = current_user.friend_sent.build(request_id: params[:request_id])
    return if friend_request_sent?(User.find(params[:request_id]))
    if @friendship.save
      flash[:success] = 'Friend Request sent'
    else
      flash[:danger] = 'Friend Request Failed'
    end
  end

  def accept_friend
    @friendship = Friendship.find_by(user_id: params[:user_id], request_id:current_user.id,status:nil)
    return unless @friendship
    @friendship.status =true
    if @friendship.save
      flash[:success] = 'Friend request accepted'
      @friendship2 = current_user.friend_sent.build(
        request_id: params[:user_id], status:true
      )
    else
      flash[:danger] = 'Friend request could not be accepted'
    end
    redirect_back(fallback_location: root_path)
  end

end
