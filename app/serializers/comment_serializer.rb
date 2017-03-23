class CommentSerializer < ActiveModel::Serializer

  # attribute :private_data, if: :is_current_user?
  # attribute :another_private_data, if: -> { scope.admin? }

  attributes  :id,
              :ticket_id,
              :user_id,
              :body,
              :created_at

  has_one :user

  def created_at
    "#{object.created_at.strftime("%m-%d-%Y %H:%M:%S")}"
  end
end
