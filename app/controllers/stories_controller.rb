class StoriesController < ApplicationController
  before_action :create_client

  def index
    @stories = Story.all

    if defined?(resp)
      @text = resp["choices"][0]["text"] 
    else
      @text = "No story for you right now! :("
    end 
  end

  def new
    @story = Story.new

    resp = @client.completions(
      parameters: {
          model: "text-davinci-003",
          prompt: "Write a silly 1-paragraph story in simple english about #{params[:input]} with 3 reading comprehension questions",
          # prompt: "type a synonym for #{params[:input]}",
          max_tokens: 3000,
          temperature: 0.8
      })

    @json = resp["choices"][0]

    array = resp["choices"][0]["text"].split('Questions')
    @text = array[0]
    @quiz_array = array[1].split()

  end

  def create
    @story = Story.new(story_params) 

    if @story.save
      redirect_back_or_to @index
    else 
      render :new, status: :unprocessable_entity
    end 
  end

  private 

  def story_params
    params.require(:story).permit(:title, :content)
  end

  def create_client
    @client = OpenAI::Client.new
  end
end
