class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :email,
              :created_at,
              :updated_at,
              :access_token,
              :role

  def created_at
    "#{object.created_at.strftime("%m-%d-%Y")}"
  end

  def updated_at
    "#{object.updated_at.strftime("%m-%d-%Y")}"
  end
end
