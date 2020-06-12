class User < ApplicationRecord

	has_many :microposts, dependent: :destroy
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	attr_accessor :remember_token
	validates :email, length: {maximum:255,message:"Max is 255 charecters"},
		format: {with: VALID_EMAIL_REGEX},uniqueness: true
		
	validate :check_length_name,if:->{name.present?}
	has_secure_password
	validates :password, length: {minimum: 6 },allow_nil: true
	
	
	def check_length_name
		if name.size>150
			errors.add :name,"length maximum is 150"
		end
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
		end		

	def remember
		self.remember_token = SecureRandom.urlsafe_base64
		update_attribute :remember_digest, User.digest(remember_token)
	end
	def forget
	update_attribute :remember_digest,nil
	end
	def authenticate? token
	BCrypt::Password.new(remember_digest).is_password?(token)	
	end	
	class <<self
	def digest token
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(token,cost: cost)
	end

end	
end
