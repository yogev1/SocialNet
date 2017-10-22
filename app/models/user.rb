class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	has_many :posts
  has_many :likes    
  
  # for friends
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :received_friends, through: :received_friendships, source: :user

  def all_friends
    friends | received_friends
  end 

  # for events
  has_many :participations
  has_many :events, through: :participations
  has_many :hosted_events, class_name: "Event", foreign_key: :organizer_id
  
end
