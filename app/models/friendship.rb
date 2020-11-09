class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :request,  class_name:'User'

    scope :friends, ->{where('status=?', true)}
    scope :not_friends, ->{where('status=?', nil)}
end
