# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Asg::Application.initialize!

ENV['RAILS_ENV'] ||= 'production'

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'gmail.com',
  user_name:            'asg.sending',
  password:             'HtbgwhY7gjm',
  authentication:       'plain',
  enable_starttls_auto: true
}