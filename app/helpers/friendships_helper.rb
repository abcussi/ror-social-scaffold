module FriendshipsHelper
  def friend_request_sent?(user)
    current_user.friend_sent.exists?(request_id: user.id, status:nil)
  end
end
