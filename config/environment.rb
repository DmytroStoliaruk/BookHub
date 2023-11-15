# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

BooksIndex.import(force: true)
