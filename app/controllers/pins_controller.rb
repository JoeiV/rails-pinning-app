class PinsController < ApplicationController
#    before_action :require_login, except: [:show, :show_by_name]
    
#    before(:each) do 
#       @user = FactoryGirl.create(:user)
#       login_user(@user)
#     end

#     after(:each) do
#       if !@user.destroyed?
#         @user.destroy
#       end
#     end   
    
  def index
      @pins = Pin.all
  end
  
  def show
      @pin = Pin.find(params[:id])
  end
  
  def show_by_name
      @pin = Pin.find_by_slug(params[:slug])
      render :show 
  end
  
  def new
      @pin = Pin.new(params[:new]) 
  end
    
  def create
      @pin = Pin.new(pin_params)
      
      if @pin.save
          redirect_to pin_path(@pin)
      else
          @errors = @pin.errors
          render :new
      end
  end  
    
  def edit
      @pin = Pin.find(params[:id])
      #render :edit
  end
   
  def update  
      @pin = Pin.find(params[:id])
      
      if @pin.update(pin_params)
          @pin.save
          redirect_to @pin
      else
          @errors = @pin.errors
          render :edit
      end
  end

    private 
    
    def pin_params
        params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id)
    end
    
    def set_pin
        @pin = Pin.find(params[:id])
    end
    
end    