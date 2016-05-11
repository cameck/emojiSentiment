class WelcomeController < ApplicationController

  def index

  end

  def show
    render 'index'
  end

  private

  def clean_params
    params.permit(:hash_tag)
  end
end
