module Resque
  module Failure
    module NotificationRecipient
      CONFIG_PATH = Rails.root.join('config/mail.yml')

      def recipients
        return unless File.exist?(CONFIG_PATH)

        options = YAML.load_file(CONFIG_PATH)[Rails.env]
        options['recipients']
      end
    end
  end
end
