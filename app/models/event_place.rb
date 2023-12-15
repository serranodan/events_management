class EventPlace < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  validates :name, :created_by, presence: true

  has_many :reservations

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "name", "location", "created_by_id", "updated_at"]
  end
end
