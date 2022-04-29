# frozen_string_literal: true

module Resque
  module Failure
    module NotificationRecipient
      CONFIG_PATH = Rails.root.join('config/mail.yml')

      def recipients
        return unless File.exist?(CONFIG_PATH)

        options = YAML.safe_load_file(CONFIG_PATH, aliases: true)[Rails.env]
        options['recipients']
      end
    end
  end
end
