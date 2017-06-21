class Company < ApplicationRecord
	after_create :send_email

	private
		def send_email
	        NotificationMailer.company_created.deliver_now
		end
end
