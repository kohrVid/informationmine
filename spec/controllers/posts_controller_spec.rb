require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  context "First page" do
    before :each do
      #this is our mock object(below). "relation" is standing in for "Post.limit(:value)"
      dummy_relation = double
      expect(dummy_relation).to receive(:offset).with(0)
      #you then want to return the double
      expect(Post).to receive(:limit).with("5").and_return(dummy_relation)
      get :index, page_size: 5, page: 1
    end

    it "should display the results" do 
      expect(response).to render_template(:index)
    end
  end

  context "Twentieth page" do
    before :each do
      dummy_relation = double
      expect(dummy_relation).to receive(:offset).with(95)
      expect(Post).to receive(:limit).with("5").and_return(dummy_relation)
      get :index, page_size: 5, page: 20
    end

    it "should display the results" do 
      expect(response).to render_template(:index)
    end
  end
end
