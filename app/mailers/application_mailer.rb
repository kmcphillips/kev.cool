# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@kev.cool'
  layout 'mailer'
end
