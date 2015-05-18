class User < ActiveRecord::Base

    def self.authenticate(email, password)
        if @user = User.find_by_email(email) && User.find_by_password(password)
            return @user 
        else
            return nil
        end
    end
   
end