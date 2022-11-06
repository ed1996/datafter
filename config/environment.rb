# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :authentication => :plain,
    :user_name => 'datafter1',
    :password => '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',
    :domain => 'heroku.com',
    :enable_starttls_auto => true
}
