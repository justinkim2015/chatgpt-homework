class StoriesController < ApplicationController
  before_action :create_client
  before_action :get_story, only: [:show, :edit, :delete]

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

    unless params[:input].nil?
      text_and_questions = Story.ask_ai(@client, params[:input])
      @text = text_and_questions[0]
      @questions = Story.process_questions(text_and_questions[1])  
    else
      @text = "No Story for you! Sorry."
      @questions = ["Q1", "Q2", "Q3"]
    end

    3.times { |i| @story.questions.build(content: @questions[i]) }
  end

  def create
    @story = Story.new(story_params) 

    if @story.save
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end 
  end

  def show
  end

  private 

  def story_params
    params.require(:story).permit(:title, :content, questions_attributes: [:content])
  end

  def create_client
    @client = OpenAI::Client.new
  end

  def get_story
    @story = Story.find(params[:id])
  end
end
