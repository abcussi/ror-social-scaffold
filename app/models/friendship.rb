class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :request, :class_name => "User"
end
