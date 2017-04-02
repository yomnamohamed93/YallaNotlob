#
class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  def index
    @friends = current_user.friends
    @requests = current_user.requested_friends
  end

  def accept
    @new_friend = User.find(params[:id])
    current_user.accept_request @new_friend
    redirect_to '/friends'
  end

  def decline
    @new_friend = User.find(params[:id])
    current_user.decline_request @new_friend
    redirect_to '/friends'
  end

  def remove
  end

  def create
    @new_friend = User.where(email: params[:friend_email]).first
    current_user.friend_request(@new_friend)
    redirect_to '/friends'
  end

  def update; end

  def destroy; end

  private

  def set_friend; end

  def friend_params; end
end
