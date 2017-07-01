class Article < ApplicationRecord
	#attr_accessor :slug
	belongs_to :user
	has_many :article_categories
	has_many :categories, through: :article_categories
	extend FriendlyId
	friendly_id :title, use: :slugged
	after_create :send_email
	validates :title, :description, :image, presence: true
	validates :title, uniqueness: true
	validates :user_id, presence: true
	validates :meta_keyword, presence: true
	mount_uploader :image, ArticlesUploader

	scope :widget_article, ->(page) { order('created_at DESC').paginate(page: page, :per_page => 3) }
	scope :article_order, ->(page) { order('created_at DESC').paginate(page: page, :per_page => 4) }
	
	private
		def send_email
			CreateArticleMailer.article_created.deliver_now
		end
end
