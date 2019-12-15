require 'test_helper'

module Resque
  module Failure
    class EmailNotificationTest < ActiveSupport::TestCase
      def test_save
        notification = Resque::Failure::EmailNotification.new(
          sample_exception, 'worker', 'queue', 'payload'
        )
        assert notification.recipients.present?, 'confirm that there are users to be notified'
        mail = notification.save
        assert mail.present?, 'email should be sent'
      end
    end
  end
end
