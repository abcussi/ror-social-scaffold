class Friendship < ApplicationRecord
  belongs_to :sent_to
  belongs_to :sent_by
end
