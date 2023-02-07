class Story < ApplicationRecord
  has_many :questions
  accepts_nested_attributes_for :questions
  belongs_to :user

  def self.process_questions(string)
    filtered_array = []
    questions = []

    quiz_array = string.strip.split(/(\d+)\./)

    quiz_array.each do |value|
      filtered_array << value if value[0] == ' '
    end

    filtered_array.each do |value|
      questions << value.split('A:')[0]
    end

    questions
  end

  def self.ask_ai(client, input)
    resp = client.completions(
      parameters: {
          model: "text-davinci-003",
          prompt: "Write a silly 1-paragraph story in simple english about #{input} with 3 reading comprehension questions in the following format \nQuestions\n1.QUESTION \nA: ANSWER \n2.QUESTION \nA: ANSWER \n3.QUESTION \nA: ANSWER",
          # prompt: "type a synonym for #{params[:input]}",
          max_tokens: 3000,
          temperature: 0.8
      })

    text_and_questions = resp["choices"][0]["text"].split('Questions')
  end 

  def self.get_json
  end
end
