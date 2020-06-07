namespace :check do
  desc "test sending email"
  task email: :environment do
    ExampleMailer.check.deliver
    puts "✅ email"
  end
end
