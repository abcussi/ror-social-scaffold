class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # has_many :friendships_requester, foreign_key: :user_id
  # has_many :friendships_requested, foreign_key: :request_id
  # has_many :friends_requester, through: :friendships_requester, source: 'requested'
  # has_many :friends_requested, through: :friendships_requested, source: 'requester'

  #has_many :friendships
  #has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'request_id'

  # Array of users who are already friends

  has_many :friend_sent, class_name: 'Friendship', foreign_key: 'user_id', inverse_of: 'user', dependent: :destroy
  has_many :friend_request, class_name: 'Friendship', foreign_key: 'request_id', inverse_of: 'request', dependent: :destroy
  has_many :friends, -> { merge(Friendship.friends) }, through: :friend_sent, source: :request
  has_many :pending_requests, -> { merge(Friendship.not_friends) }, through: :friend_sent, source: :request
  has_many :received_requests, -> { merge(Friendship.not_friends) }, through: :friend_request, source: :user






  def friends
    friends_array = friendships.map { |friendship| friendship.request if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

end
