class FriendshipsController < ApplicationController
  include ApplicationHelper

  def create
    return if current_user.id == params[:user_id] # Disallow the ability to send yourself a friend request
    # Disallow the ability to send friend request more than once to same person
    return if friend_request_sent?(User.find(params[:user_id]))
    # Disallow the ability to send friend request to someone who already sent you one
    return if friend_request_recieved?(User.find(params[:user_id]))

    @user = User.find(params[:user_id])
    @friendship = current_user.friend_sent.build(request_id: params[:user_id])
    if @friendship.save
      flash[:success] = 'Friend Request Sent!'
    else
      flash[:danger] = 'Friend Request Failed!'
    end
    redirect_back(fallback_location: root_path)
  end

  def accept_friend
    @friendship = Friendship.find_by(user_id: params[:user_id], request_id: current_user.id, status: false)
    return unless @friendship # return if no record is found

    @friendship.status = true
    if @friendship.save
      flash[:success] = 'Friend Request Accepted!'
      @friendship2 = current_user.friend_sent.build(request_id: params[:user_id], status: true)
      @friendship2.save
    else
      flash[:danger] = 'Friend Request could not be accepted!'
    end
    redirect_back(fallback_location: root_path)
  end

  def decline_friend
    @friendship = Friendship.find_by(user_id: params[:user_id], request_id: current_user.id, status: false)
    return unless @friendship # return if no record is found

    @friendship.destroy
    flash[:success] = 'Friend Request Declined!'
    redirect_back(fallback_location: root_path)
  end

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
end
