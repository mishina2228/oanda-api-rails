require 'test_helper'

module Resque
  module Failure
    class EmailNotificationTest < ActiveSupport::TestCase
      CONFIG_PATH = Rails.root.join('test/data/config/mail.yml')

      setup do
        @original = Resque::Failure::NotificationRecipient.send(:remove_const, :CONFIG_PATH)
        Resque::Failure::NotificationRecipient.const_set(:CONFIG_PATH, CONFIG_PATH)
      end

      teardown do
        Resque::Failure::NotificationRecipient.send(:remove_const, :CONFIG_PATH)
        Resque::Failure::NotificationRecipient.const_set(:CONFIG_PATH, @original)
      end

      def test_save
        notification = Resque::Failure::EmailNotification.new(
          sample_exception, 'worker', 'queue', 'payload'
        )
        assert notification.recipients.present?, 'confirm that there are users to be notified'
        mail = notification.save
        assert mail.present?, 'email should be sent'
      end

      def test_output_error_details
        notification = Resque::Failure::EmailNotification.new(
          sample_exception, 'worker', 'queue', 'payload'
        )
        assert notification.recipients.present?

        JobFailureNoticeMailer.stub(:with, ->(**_options) {raise 'mock error'}) do
          assert_output(/RuntimeError mock error/) {notification.save}
        end
      end
    end
  end
end
