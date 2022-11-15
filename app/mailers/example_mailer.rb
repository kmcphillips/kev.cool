# frozen_string_literal: true
class ExampleMailer < ApplicationMailer
  default to: -> { Rails.application.credentials.improvmx.email_test_recipient }

  def check
    mail(subject: "Successfully delivered mail from kev.cool")
  end
end
