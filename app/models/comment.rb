class Comment < ApplicationRecord
  acts_as_paranoid

  belongs_to :ticket
  belongs_to :user

  validates_presence_of :ticket_id,
                        :user_id,
                        :body
end
