module FriendshipsHelper
  def friend_request_sent?(user)
    current_user.friend_sent.exists?(request_id: user.id, status:nil)
  end

  def friend_request_received?(user)
    current_user.friend_request.exists?(request_id: user.id, status:nil)
  end
end
