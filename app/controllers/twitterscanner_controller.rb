class TwitterscannerController < ApplicationController
skip_before_action :verify_authenticity_token

  def process_request
    p params
  end

end
