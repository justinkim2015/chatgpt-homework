class AddRefToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :story
  end
end
