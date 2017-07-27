class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
       		:recoverable, :rememberable, :trackable, :validatable, :confirmable,
       		:omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
	extend FriendlyId
  	friendly_id :username, use: :slugged
	has_many :articles
	before_save { self.email = email.downcase }
	#validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 20 },
			#format: { without: /\s/ }
	VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :name, presence: true, length: { minimum: 4, maximum: 35 }
	validates :email, presence: true, uniqueness: true, 
				length: { minimum: 4, maximum: 45 },
				format: { with: VALID_EMAIL_REGEX }

	# validates :password, presence: true
	# has_secure_password
	# def send_devise_notification(notification, *args)
	#   devise_mailer.send(notification, self, *args).deliver_later
	# end
	
	def self.from_omniauth(auth)
      # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      	
      #   user.provider = auth.provider
      #   user.uid = auth.uid
      #   user.email = auth.info.email
      #   user.password = Devise.friendly_token[0,20]
      # end
     #  	data = auth.info
	    # user = User.where(email: data['email']).first
	    # user.skip_confirmation!
	    # user.save
	    # # Uncomment the section below if you want users to be created if they don't exist
	    # unless user
	    #     user = User.create(name: data['name'],
	    #        email: data['email'],
	    #        password: Devise.friendly_token[0,20]
	    #     )
	    # end

      	user = where(provider: auth.provider, uid: auth.uid).first
      	
	   	unless user.present?
	      user            = new
	      user.email      = auth.info.email
	      user.name 	  = auth.info.name
	      # user.last_name  = auth.info.name.to_s.split(" ")[1]
	      user.provider   = auth.provider
	      user.uid        = auth.uid

	     	password = Devise.friendly_token[0,10]

	      user.password              = password
	      user.password_confirmation = password
	      user.skip_confirmation!
	      user.save!
	    end

	   	user
	   # 	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		  #   user.email = auth.info.email
		  #   user.password = Devise.friendly_token[0,20]
		  #   user.name = auth.info.name   # assuming the user model has a name
		  #   #user.image = auth.info.image # assuming the user model has an image
		  #   # If you are using confirmable and the provider(s) you use validate emails, 
		  #   # uncomment the line below to skip the confirmation emails.
		  #   user.skip_confirmation!
	  	# end
	end
  	def self.new_with_session(params, session)
	    super.tap do |user|
	      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	        user.email = data["email"] if user.email.blank?
	      end
	    end
	end
	
  	
end
