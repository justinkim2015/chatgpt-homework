class StoriesController < ApplicationController
  before_action :create_client

  def index
    # resp = @client.completions(
    #   parameters: {
    #       model: "text-davinci-003",
    #       # prompt: "Write a silly 1-paragraph story in simple english about a dog with reading comprehension questions",
    #       prompt: 'say hi',
    #       max_tokens: 3,
    #       temperature: 0.8
    #   })


    if defined?(resp)
      @text = response["choices"][0]["text"] 
    else
      @text = "No story for you right now! :("
    end 
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params) 
  end

  private 

  def story_params
    params.require(:story).permit(:title, :content)
  end

  def create_client
    @client = OpenAI::Client.new
  end
end
