class Category < ApplicationRecord
	validates :name, presence: true, length: { minimum: 4, maximum: 20 }
	validates_uniqueness_of :name
	extend FriendlyId
  	friendly_id :name, use: :slugged
end
