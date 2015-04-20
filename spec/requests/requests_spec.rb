require "spec_helper"

RSpec.describe "Our Application Routes" do
    
    describe "GET /pins/name-:slug" do
        
        it 'renders the pin/show template' do
            pin = Pin.first
            get "/pins/name-#{pin.slug}"
            expect(response).to render_template("pins/show")
        end
        
        it 'populates the @pin variable with the appropriate pin' do
            pin = Pin.first
            get "/pins/name-#{pin.slug}"
            expect(assigns[:pins]).to eq(assigns[:pins])
        end
    end
  
end