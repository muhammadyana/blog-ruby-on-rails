class Article < ApplicationRecord
	#attr_accessor :slug
	extend FriendlyId
	friendly_id :title, use: :slugged
	after_create :send_email
	validates :title, :description, :image, presence: true
	validates :title, uniqueness: true
	mount_uploader :image, ArticlesUploader
	private
		def send_email
			CreateArticleMailer.article_created.deliver_now
		end
end
