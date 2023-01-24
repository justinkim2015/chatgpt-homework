class Story < ApplicationRecord
  has_many :questions
  accepts_nested_attributes_for :questions
  
  def self.process_questions(array)
    filtered_array = []
    questions = []

    quiz_array = array.split(/(\d+)\./)

    quiz_array.each do |value|
      filtered_array << value if value[0] == ' '
    end

    filtered_array.each do |value|
      questions << value.split('A:')[0]
    end

    questions
  end
end
