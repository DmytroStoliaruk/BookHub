# frozen_string_literal: true

class AddBookValidation < ActiveRecord::Migration[7.0]
  def change
    change_column_null :books, :title, false
    change_column_null :books, :author, false
  end
end
