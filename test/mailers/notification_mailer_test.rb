require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "company_created" do
    mail = NotificationMailer.company_created
    assert_equal "Company created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
