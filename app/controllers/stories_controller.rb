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

    unless params[:input].nil?
      resp = @client.completions(
        parameters: {
            model: "text-davinci-003",
            prompt: "Write a silly 1-paragraph story in simple english about #{params[:input]} with 3 reading comprehension questions in the following format \nQuestions \n1.QUESTION \nA: ANSWER \n2.QUESTION \nA: ANSWER \n3.QUESTION \nA: ANSWER",
            # prompt: "type a synonym for #{params[:input]}",
            max_tokens: 3000,
            temperature: 0.8
        })
      @json = resp["choices"][0]

      text_and_questions = resp["choices"][0]["text"].split('Questions')
      @text = text_and_questions[0]
      @questions = Story.process_questions(text_and_questions[1])  
    else
      @text = "No Story for you! Sorry."
      @questions = ["Q1", "Q2", "Q3"]
    end

    3.times do |i|
      @story.questions.build(content: @questions[i])
    end    
  end

  def create
    @story = Story.new(story_params) 

    if @story.save
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end 
  end

  private 

  def story_params
    params.require(:story).permit(:title, :content, questions_attributes: [:content])
  end

  def create_client
    @client = OpenAI::Client.new
  end
end
