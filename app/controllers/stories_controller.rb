class StoriesController < ApplicationController
  before_action :create_client
  before_action :get_story, only: [:show, :edit, :delete]

  def index
    @stories = Story.all

    if defined?(resp)
    else
    end 
  end

  def new
    @story = Story.new

    unless params[:input].nil?
      resp = @client.completions(
        parameters: {
            model: "text-davinci-003",
            prompt: "Write a silly 1-paragraph story in simple english about #{params[:input]} with 3 reading comprehension questions in the following format \nQuestions \n1.QUESTION \nA: ANSWER \n2.QUESTION \nA: ANSWER \n3.QUESTION \nA: ANSWER",
            max_tokens: 3000,
            temperature: 0.8
        })
      
      @json = resp["choices"][0]

      text_and_questions = resp["choices"][0]["text"].split('Questions')
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
    @story = Story.new(story_params) 

    if @story.save
      redirect_to @story
    else 
      render :new, status: :unprocessable_entity
    end 
  end

  def show
  end

  private 

  def story_params
    params.require(:story).permit(:title, :content, questions_attributes: [:content, :answer])
  end

  def create_client
    @client = OpenAI::Client.new
  end

  def get_story
    @story = Story.find(params[:id])
  end
end
