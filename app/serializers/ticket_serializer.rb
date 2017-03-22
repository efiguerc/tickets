class TicketSerializer < ActiveModel::Serializer

  # attribute :private_data, if: :is_current_user?
  # attribute :another_private_data, if: -> { scope.admin? }

  attributes  :id,
              :category,
              :title,
              :status,
              :priority,
              :created_at,
              :updated_at
  has_one :customer
  has_one :agent

  def created_at
    "#{object.created_at.strftime("%m-%d-%Y")}"
  end

  def updated_at
    "#{object.updated_at.strftime("%m-%d-%Y")}"
  end
end
