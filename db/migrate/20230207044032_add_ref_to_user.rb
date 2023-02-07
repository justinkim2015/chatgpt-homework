class AddRefToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :user
    add_reference :stories, :user
  end
end
