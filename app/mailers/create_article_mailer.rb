class CreateArticleMailer < ApplicationMailer
	def article_created(name='Yana')
		@subject = "There is a new article from #{name}"
		mail to: "muhammadyanaa@gmail.com"
		
	end
end
