class StoriesController < ApplicationController
  before_action :create_client
  before_action :get_story, only: [:show, :edit, :update, :delete]
  before_action :check_permissions, only: [:delete, :edit, :update]

  def index
    @stories = Story.all
  end

  def show
  end

  def new
    @story = Story.new

    unless params[:input].nil?
      text_and_questions = Story.ask_ai(@client, params[:input])
      @text = text_and_questions[0]
      @questions = Story.process_questions(text_and_questions[1])  
    else
      @text = "Type in a word and make a story!"
    end

    if defined?(@questions)
      3.times do |i|
        @story.questions.build(content: @questions[i])
      end    
    end 
  end

  def create
    @story = current_user.stories.new(story_params)

    if @story.save
      redirect_to @story
    else 
      render :new, status: :unprocessable_entity
    end 
  end

  def edit
  end

  def update
    if @story.update(story_params)
      redirect_to @story, notice: 'Story was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @story.destroy
    redirect_to root_path, notice: 'Story was successfully destroyed.'
  end

  private 

  def story_params
    params.require(:story).permit(:title, :content, questions_attributes: [:content, :answer, :user_id])
  end

  def create_client
    @client = OpenAI::Client.new
  end

  def get_story
    @story = Story.find(params[:id])
  end

  def check_permissions 
    unless current_user.admin? || current_user.id == @story.user_id
      redirect_to root_path, alert: "You don't have sufficient permissions to do this."
    end
  end
end
