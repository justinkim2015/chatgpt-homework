class AddNotNullToColumns < ActiveRecord::Migration[7.0]
  def change
    change_column_null :questions, :content, false, "null"
    change_column_null :questions, :answer, false, "null"
    change_column_null :stories, :content, false, "null"
    change_column_null :stories, :title, false, "null"
  end
end
