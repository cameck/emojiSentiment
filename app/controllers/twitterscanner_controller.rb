class TwitterscannerController < ApplicationController
skip_before_action :verify_authenticity_token

  def process_request
    # p params
    render :nothing => true, :status => :ok
  end

  def response
    @response = HTTParty.get("http://intense-coast-35405.herokuapp.com/process-request")
    @http_json = JSON.parse(@response.body)
    p http_json
  end

end
