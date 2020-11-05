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
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :friend_sent, class_name: 'Friendship', foreign_key: 'user_id', dependent: :destroy
  has_many :friend_request, class_name: 'Friendship', foreign_key: 'request_id', dependent: :destroy
  #has_many :friends, -> { where status: true }, through: :friend_sent, source: :request
  has_many :pending_requests, -> { where status: nil }, through: :friend_sent, source: :request
  has_many :received_requests, -> { where status: nil }, through: :friend_request, source: :user

end
