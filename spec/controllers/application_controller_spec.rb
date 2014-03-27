require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      render :template => 'chat/index'
    end
  end

  describe "set_iphone_format" do
    it "set iphone format" do
      request.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 7_0_6 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11B651 Safari/9537.53"
      get :index
      request.format.symbol.should eq(:iphone)
      response.should render_template(layout: "iphone")
    end

    it "set html format" do
      get :index
      request.format.symbol.should eq(:html)
      response.should render_template(layout: "application")
    end
  end

end
