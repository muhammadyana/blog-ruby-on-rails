class Gallery < ApplicationRecord
	mount_uploader :image, GalleryUploader
end
