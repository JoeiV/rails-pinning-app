class User < ActiveRecord::Base
    
    attr_accessor :password
    #before_save :encrypt_password
  
    validates_confirmation_of :password
    validates_presence_of :password, :on => :create
    validates_presence_of :first_name, :last_name, :email
    validates_uniqueness_of :email
    
    has_secure_password
    
    has_many :pins
 
#     def encrypt_password
#         if password.present?
#             self.password_salt = BCrypt::Engine.generate_salt
#             self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
#         end
#     end

    
    def self.authenticate(email, password)
      @user = User.find_by_email(email)

      if !@user.nil?
        if @user.authenticate(password)
          return @user
        end
      end

      return nil
    end

  
end