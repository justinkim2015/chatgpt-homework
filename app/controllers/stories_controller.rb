class StoriesController < ApplicationController
  before_action :create_client
  
  def index
  end

  private 

  def create_client
    client = OpenAi::Client.new
  end
end
