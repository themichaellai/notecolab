# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Notecolab::Application.initialize!

Notecolab::Application.config.name = 'NoteShare'
