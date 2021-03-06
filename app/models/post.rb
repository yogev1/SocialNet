class Post < ApplicationRecord
	belongs_to :user
	has_many :likes
	has_many :comments

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def self.search(search)
    where("description LIKE ? OR title LIKE ? ", "%#{search.downcase}%", "%#{search.downcase}%") 
  end 
end
