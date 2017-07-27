class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  	has_many :posts, dependent: :destroy
  	has_many :friendships
    # has_many :friends, through: :friendships
    has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

    has_many :active_friends, through: :friendships, source: :friend
    has_many :received_friends, through: :received_friendships, source: :user
    # has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
    # has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user

# to call all your friends

    def friends
      active_friends | received_friends
    end

# to call your pending sent or received

    def pending
      pending_friends | requested_friendships
    end

end
