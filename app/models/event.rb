class Event < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/	

  # users
  has_many :participations 
  has_many :participants, through: :participations, source: :user
  belongs_to :organizer, class_name: "User", foreign_key: :organizer_id

  # comments
  has_many :event_comments
end
