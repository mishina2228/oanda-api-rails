# frozen_string_literal: true

require 'test_helper'

module Resque
  module Failure
    class EmailNotificationTest < ActiveSupport::TestCase
      setup do
        @notification = Resque::Failure::EmailNotification.new(
          sample_exception, 'worker', 'queue', 'payload'
        )
      end

      def test_save
        @notification.stub(:recipients, %w[test1@example.com test2@example.com]) do
          assert @notification.recipients.present?, 'confirm that there are users to be notified'
          mail = @notification.save
          assert mail.present?, 'email should be sent'
        end
      end

      def test_output_error_details
        @notification.stub(:recipients, %w[test1@example.com test2@example.com]) do
          assert @notification.recipients.present?

          JobFailureNoticeMailer.stub(:with, ->(_options) {raise 'mock error'}) do
            assert_output(/RuntimeError mock error/) {@notification.save}
          end
        end
      end
    end
  end
end
