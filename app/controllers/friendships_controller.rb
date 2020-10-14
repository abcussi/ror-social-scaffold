class FriendshipsController < ApplicationController

  def new
    @friendship = Friendship.new
  end

  def create
   @friendship = Friendship.new(friendship_params)
   respond_to do |format|
    if @friendship.save
      format.html {redirect_to @friendship}
    else
      format.html{render 'new'}
    end
  end

  private 
  def friendship_params
    params.require(:friendship).permit(:user_id, :request_id, :status)
  end
end
