class User < ActiveRecord::Base

    def self.authenticate(email, password)
        if @user = User.find(params[:email, :password])
            true
            render :show
        else
            false
        end
    end
    
end
