require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      render :template => 'public/index'
    end
  end

  describe "iphone format, layout" do
    before(:each) do
      request.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 7_0_6 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11B651 Safari/9537.53"
      get :index
    end

    it "should correct format" do
      request.format.symbol.should eq(:iphone)
    end

    it "should correct layout" do
      response.should render_template(layout: "mobile")
    end
  end

  describe "android format, layout" do
    before(:each) do
      request.user_agent = "Mozilla/5.0 (Linux; U; Android 4.0.3; ja-jp; AT570 Build/IML74K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Safari/534.30"
      get :index
    end

    it "should correct format" do
      request.format.symbol.should eq(:android)
    end

    it "should correct layout" do
      response.should render_template(layout: "mobile")
    end
  end

  describe "non mobile format, layout" do
    before(:each) do
      get :index
    end

    it "should correct format" do
      request.format.symbol.should eq(:html)
    end

    it "should correct layout" do
      response.should render_template(layout: "application")
    end
  end
end
