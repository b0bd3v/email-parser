# frozen_string_literal: true

def email_files(from)
  Dir[Rails.root.join('spec', 'fixtures', 'emails', '*.eml')].select do |file_path|
    File.read(file_path).include?(from)
  end.sort
end

def double_mail(file_content)
  double('Mail',
         body: double('Body', decoded: file_content, to_s: file_content),
         subject: file_content.match(/Subject: (.+)/)[1].strip)
end
