require 'test_helper'

module Resque
  module Failure
    class EmailNotificationTest < ActiveSupport::TestCase
      def test_save
        notification = Resque::Failure::EmailNotification.new(
          sample_exception, 'worker', 'queue', 'payload'
        )
        assert notification.recipients.present?, 'there should be notification target users'
        mail = notification.save
        assert mail.present?, 'email should be sent'
      end
    end
  end
end
