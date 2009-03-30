require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProtectedController do

  #Delete these examples and add some real ones
  it "should use ProtectedController" do
    controller.should be_an_instance_of(ProtectedController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end
