# frozen_string_literal: true
class ExampleMailer < ApplicationMailer
  default to: -> { Rails.application.secrets[:email_test_recipient] }

  def test
    mail(subject: "Successfully delivered mail from kev.cool")
  end
end
