class TwitterscannerController < ApplicationController
skip_before_action :verify_authenticity_token

  def process_request
    # p params
    render :nothing => true, :status => :ok
  end

  def response
  end

end
