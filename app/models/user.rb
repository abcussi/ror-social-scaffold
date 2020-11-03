class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :accepted_friendships, -> { where status: true }, class_name: 'Friendship'
  has_many :requested_friendships, -> { where status: nil }, class_name: 'Friendship'
  has_many :pending_friendships, -> { where status: nil }, class_name: 'Friendship'
  has_many :friends, through: :accepted_friendships
  has_many :requested_friends, through: :requested_friendships, source: :user
  has_many :pending_friends, through: :pending_friendships, source: :request

  def user_friends_post
    Post.where(user_id: self).includes([:user]).order('created_at DESC').includes([:image_attachment]).includes([:likes]) + Post.where(user_id: friends).includes([:user]).order('created_at DESC').includes([:image_attachment]).includes([:likes])
  end

end
