ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers - stymied by SQLite locking itself enthusiastically.
  parallelize(workers: 1, with: :threads)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def get_admin_user
    User.find_by(email: 'judith.owens@civica.co.uk')
  end
end
