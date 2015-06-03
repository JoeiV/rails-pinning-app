require 'spec_helper'

before_action :require_login, except: [:show, :show_by_name]

    RSpec.describe PinsController do
    
    describe "GET index" do
        
        it 'renders the index template' do
            get :index
            expect(response).to render_template("index")
        end
        
        it 'populates @pins with all pins' do
            get :index
            expect(assigns[:pins]).to eq(Pin.all)
            #TO DO: change to show only the logged in user’s pins
        end
      
    end
    
   describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end
    
    describe "GET edit" do
        
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        resource_type: "rails"}    
    end
                    
    it 'responds with successfully' do
      get :edit
      expect(response.success?).to be(true)
    end
    
    it 'renders the edit view' do
      get :edit      
      expect(response).to render_template(:edit)
    end
    
    it 'assigns an instance variable to the edited pin' do
      get :edit
      expect(assigns(:pin)).to be(@pin.id)
    end
    
    it 'responds with a redirect following a POST to /pins/edit' do
      post :edit, pin: @pin_hash.id
      expect(response.redirect?).to be(true)
    end

  end
  
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        resource_type: "rails"}    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
    it 'responds with a redirect' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end
    
    it 'creates a pin' do
      post :create, pin: @pin_hash  
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(assigns[:errors].present?).to be(true)
    end    
    
  end

    describe "POST update" do
        before(:each) do
          @pin_hash = { 
            title: "Rails Wizard", 
            url: "http://railswizard.org", 
            slug: "rails-wizard", 
            text: "A fun and helpful Rails Resource",
            resource_type: "rails"}    
        end

        after(:each) do
          pin = Pin.find_by_slug("rails-wizard")
          if !pin.nil?
            pin.destroy
          end
        end

        it 'responds with a redirect' do
          post :create, pin: @pin_hash
          expect(response.redirect?).to be(true)
        end

        it 'creates a pin' do
          post :create, pin: @pin_hash  
          expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
        end

        it 'redirects to the show view' do
          post :create, pin: @pin_hash
          expect(response).to redirect_to(pin_url(assigns(:pin)))
        end

        it 'redisplays new form on error' do
          # The title is required in the Pin model, so we'll
          # delete the title from the @pin_hash in order
          # to test what happens with invalid parameters
          @pin_hash.delete(:title)
          post :create, pin: @pin_hash
          expect(response).to render_template(:new)
        end

        it 'assigns the @errors instance variable on error' do
          # The title is required in the Pin model, so we'll
          # delete the title from the @pin_hash in order
          # to test what happens with invalid parameters
          @pin_hash.delete(:title)
          post :create, pin: @pin_hash
          expect(assigns[:errors].present?).to be(true)
        end    

      end 

end
