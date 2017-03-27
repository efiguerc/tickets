class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :email,
              :created_at,
              :updated_at,
              :role

  attribute :access_token, if: :is_current_user?

  def created_at
    "#{object.created_at.strftime("%m-%d-%Y")}"
  end

  def updated_at
    "#{object.updated_at.strftime("%m-%d-%Y")}"
  end

  def is_current_user?
    object.id == current_user.id
  end
end
