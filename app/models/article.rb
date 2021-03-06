# require 'elasticsearch/model'

class Article < ApplicationRecord
	# include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
	#attr_accessor :slug
	is_impressionable
	acts_as_taggable
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
# Article.import # for auto sync model with elastic search
