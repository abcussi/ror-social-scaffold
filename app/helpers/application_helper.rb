module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  # Checks whether or not a user has had a friend request sent to them by the current user
  # returning either true or false
  def friend_request_sent?(user)
    current_user.friend_sent.exists?(sent_to_id: user.id, status: false)
  end

  # Checks whether or not a user has sent a friend request to the current user
  # returning either true or false
  def friend_request_recieved?(user)
    current_user.friend_request.exists?(sent_by_id: user.id, status: false)
  end

  # Checks whether or not a user has had a friend request sent to them by the current user
  # or if the current user has been sent a friend request by the user
  # returning either true or false
  def possible_friend?(user)
    request_sent = current_user.friend_sent.exists?(sent_to_id: user.id)
    request_recieved = current_user.friend_request.exists?(sent_by_id: user.id)

    return true if request_sent != request_recieved
    return true if request_sent == request_recieved && request_sent == true
    return false if request_sent == request_recieved && request_sent == false
  end

end
