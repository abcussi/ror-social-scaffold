class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    users_list = []
    User.all.each do |us|
      # if us != current_user
      #   users_list << us
      # end
      users_list << us unless us == current_user
    end
    #@users = User.all
    @users_list = users_list
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
