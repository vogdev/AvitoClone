class Annonce < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	 has_attached_file :image, styles: { medium: "400x600>", thumb: "150x150"}
      validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
